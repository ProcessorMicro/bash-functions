#!/bin/bash

function ERROR() {
  echo -e "\nERROR: $@"
  exit
}

function WARNING() {
  echo -e "\nWARNING: $@"
}

function VERIFY_COMMAND() {
  local Error
  unset RESULT
  RESULT=( $(whereis $1) )
  if (( ${#RESULT[*]} < 2 )) ; then
    (( $3 == 1 )) && return 1			# No message
    (( $3 > 1 )) && Error="ERROR" || Error="WARNING"
    (( ${#RESULT[2]} < 2 )) && echo -e "${Error}: Command \"$1\" not found. $2."
    (( $3 > 1 )) && exit $3 || return $3
  fi
}

function VERIFY_REQUIREMENTS() {
  VERIFY_COMMAND less "This is a required command" "2"
  VERIFY_COMMAND sort "This is a required command" "2"
  if ! VERIFY_COMMAND gawk "" "1" ; then
    echo -e "Command \"gawk\" not found. testing for \"awk\"."
    if VERIFY_COMMAND awk "" "1" ; then
      cd "${RESULT[1]%/*}"
      ln -s awk gawk
      echo -e "Created link \"gawk -> awk\" in \"$(pwd)\"."
    else
      echo -e "Neither command \"gawk\" nor \"awK\" are found. One of them is a required command."
    fi
  fi
  VERIFY_COMMAND nmap "This command is needed only if you use the network functions." 0
  VERIFY_COMMAND yad  "This command is needed only if you use the -G (GUI) option in any function." 0
}

function Install() {
  Bash="$( whereis -b bash )"
  [[ -n ${Bash#*:} ]] || ERROR "\"bash\" is not installed on this system."

  echo -e "Install script for the \"functions.sh\" distribution.
  Beginning installation..."

  mkdir -p "${BinDir}"				# Ensure it exists
  [[ :${PATH}: =~ :${BinDir}: ]] || WARNING "\nYour search path \"PATH\" doesn't contain the path \"${BinDir}\".\nIt is required for \"functions.sh\" to operate correctly.\n"

  VERIFY_REQUIREMENTS				# All the apps that are needed

  # /etc/profile.d/...
  if [[ -f /etc/${DefaultsFile} ]] ; then
    echo -e "The GET_ARGS global defaults file \"/etc/${DefaultsFile}\" exists\n    so it was not overwritten.\nManually merge the install file with your existing one.\nThe install version is in \"${WhereAmI}/${DefaultsFile}\"."
  else
    cp ${DefaultsFile} /etc/${DefaultsFile}  || ERROR "Copy of script \"${DefaultsFile}\" failed."
  fi
  cp -f ${ExtraFunctions} /etc/${ExtraFunctions} || ERROR "Copy of script \"${ExtraFunctions}\" failed."
  chown root:root /etc/${ExtraFunctions} /etc/${DefaultsFile}
  chmod 644 /etc/${ExtraFunctions} /etc/${DefaultsFile}

  # /usr/local/bin/...
  cd bin
  while read -u 3 Script ; do
    cp -f "${Script}" "${BinDir}" || ERROR "Copy of script \"${Script}\" failed."
    chown root:root "${BinDir}/${Script}"
    chmod 755 "${BinDir}/${Script}"
  done 3< <( find -type f )

  echo -e "\nInstallation of \"functions.sh\" complete."
}

function UnInstall() {
  echo -e "Uninstall script for the \"functions.sh\" distribution.
  Beginning uninstall...\n"

  read -p "Do you really want to uninstall the \"functions.sh\" distribution? " Ans
  [[ ${Ans,,} =~ ^y ]] || exit
  rm -f "/etc/${DefaultsFile}"
  rm -f "/etc/${ExtraFunctions}"

  cd bin
  while read -u 3 Script ; do
    rm -f "${BinDir}/${Script}"
  done 3< <( find -type f )

  cd "${WhereAmI}/.."
  ( sleep 3; rm -rf "${WhereAmI}" ; echo -e "\nUninstall of \"functions.sh\" complete.\n" ) &
}

(( $( id -u ) )) && ERROR "You must run this script a \"root\"."

BinDir="/usr/local/bin"				# Where we want to put the scripts
DefaultsFile="profile.d/FUNCTIONS-SH-GLOBAL-DEFAULTS.sh"
ExtraFunctions="profile.d/FUNCTIONS-SH-EXTRA-FUNCTIONS.sh"

ThisIsMe="$(realpath "${BASH_SOURCE[0]}")"	# Path of this script
WhoAmI="${ThisIsMe##*/}"			# Basename of this script
WhereAmI="${ThisIsMe%/*}"			# DirName of this script
cd "${WhereAmI}"				# Go there

if [[ ${WhoAmI} == install.sh ]] ; then
  Install
else
  UnInstall
fi
