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
  if [[ :${PATH}: =~ :${BinDir}: || :${PATH}: =~ :$(echo ${BinDir}): ]] ; then
    WARNING "\nYour search path \"PATH\" doesn't contain the path \"${BinDir}\".\nIt is required for \"functions.sh\" to operate correctly.\n"
  fi

  VERIFY_REQUIREMENTS				# All the apps that are needed

  # /etc/profile.d/...
  if [[ -f ${Etc}/${DefaultsFile} ]] ; then
    echo -e "The GET_ARGS global defaults file \"${Etc}/${DefaultsFile}\" exists\n    so it was not overwritten.\nManually merge the install file with your existing one.\nThe install version is in \"${WhereAmI}/${DefaultsFile}\"."
  else
    cp ${DefaultsFile} ${Etc}/${DefaultsFile} || ERROR "Copy of script \"${DefaultsFile}\" failed."
  fi
  cp -f ${ExtraFunctions} ${Etc}/${ExtraFunctions} || ERROR "Copy of script \"${ExtraFunctions}\" failed."
  chown root:root ${Etc}/${ExtraFunctions} ${Etc}/${DefaultsFile}
  chmod 644 ${Etc}/${ExtraFunctions} ${Etc}/${DefaultsFile}

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

  [[ ${Ans,,} =~ ^y ]] || exit
  rm -f "${Etc}/${DefaultsFile}" || ERROR "while removing script \"${Etc}/${DefaultsFile}\"."
  rm -f "${Etc}/${ExtraFunctions}" || ERROR "while removing script \"${Etc}/${ExtraFunctions}\"."

  cd bin
  while read -u 3 Script ; do
    rm -f "${BinDir}/${Script}" || ERROR "while removing script \"${BinDir}/${Script}\"."
  done 3< <( find -type f )

  cd "${WhereAmI}/.."
  ( sleep 3; rm -rf "${WhereAmI}" ; echo -e "\nUninstall of \"functions.sh\" complete.\n" ) &
}

Ubf="useful-bash-functions"
ThisIsMe="$(realpath "${BASH_SOURCE[0]}")"	# Path of this script
WhoAmI="${ThisIsMe##*/}"			# Basename of this script
WhoAmIaction="${WhoAmI%.*}"
WhereAmI="${ThisIsMe%/*}"			# DirName of this script
cd "${WhereAmI}"				# Go there

DefaultsFile="FUNCTIONS-SH-GLOBAL-DEFAULTS.sh"
ExtraFunctions="FUNCTIONS-SH-EXTRA-FUNCTIONS.sh"
ForWho="$( id -u -n )"

if [[ $1 =~ -h ]] ; then
  echo -e "${WhoAmIaction^} the \"${Ubf}\" distribution.\nUsage: ${WhoAmI} [--system-install]\nWhere:\n  --system-install\n    ${WhoAmIaction^} as a system-wide appplication.\n    The default is to ${WhoAmIaction} it for only this user: ${ForWho}"
  exit
elif [[ $1 == --system-${WhoAmIaction} ]] ; then
  (( $( id -u ) )) && ERROR "You must run this script as \"root\"."
  BinDir="/usr/local/bin"			# Where we want to put the system scripts
  EtcDir="/etc"					# Where we want to put the system scripts
  DefaultsFile="profile.d/${DefaultsFile}"
  ExtraFunctions="profile.d/${ExtraFunctions}"
  ForWho="root"
else
  BinDir="~/bin"				# Where we want to put the user scripts
  EtcDir="${BinDir}"				# Where we want to put the user scripts
fi

read -p "Do you really want to ${WhoAmIaction} ${Ubf} (y, n)? " Ans
[[ ${Ans,,} == y ]] || exit

if [[ ${WhoAmI} == install.sh ]] ; then
  Install
else
  UnInstall
fi
