# <a id="top">Useful Bash Functions</a>

## <a id="purpose">Purpose</a>

The bash functions in the file `functions.sh` can be used to enhance and manage bash scripts.
When the file `functions.sh` is included (sourced) in a parent script more than 70 useful functions and many variables are available to the parent script.
Some additional gawk scripts present in this distribution are used by and provide support for `functions.sh`.
Also included in the distribution are a few useful support scripts.  
This distribution is designed to work in a bash shell environment on a system executing the Linux O/S.

The primary function in `functions.sh` is `GET_ARGS`. It is called with arguments (directives) that "define" the options and arguments available to a parent script.
Also it parses the parent script options on the command line when the parent script is invoked as a command.
The `GET_ARGS_DIRECTIVES` also describe the script purpose and the meaning of each option/argument defined.
This makes the parent script self documenting with man-like pages.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

## <a id="contents">Contents</a>

&nbsp;&nbsp;&nbsp;&nbsp;[Purpose](#purpose)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[Contents](#contents)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[Caveat](#caveat)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[Installation](#installation)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Required Packages](#required-packages)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Installation Procedure](#installation-procedure)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[Summary of the Major Functions and Variables](#summary)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[Major Functions](#major-functions)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[Major Global Variables](#major-global-variables)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[Documentation](#documentation)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Script Documentation](#script-documentation)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[MKSCRIPT](#mkscript)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[FIND-FUNCTIONS](#find-functions)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[EXTRA-BASH-FUNCTIONS.sh](#extra-bash-commands)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Function Documentation](#function-documentation)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[GET_ARGS](#GET_ARGS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Example of help implemented by GET_ARGS](#example-of-help)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[IS_EXCLUSIVE](#IS_EXCLUSIVE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Example of GET_ARGS and IS_EXCLUSIVE](#example-of-get-args)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Sample Code for GET_ARGS and IS_EXCLUSIVE](#coding-of-get-args)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ASK et al.](#ASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[TMP_FILE_CREATE et al.](#TMP_FILE_CREATE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[Experiment](#tryme)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Experiment with ASK](#experiment-with-ASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Experiment with ASK_WITH_MENU](#experiment-with-ASK-WITH-MENU)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Experiment with Some Other Functions](#experiment-with-other-functions)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[COLOR](#color)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[ERROR & WARNING](#error-warning)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[PAD_IT, TRIM & ZERO_FILL](#padit-trim-zerofill)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[PAUSE](#pause)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[PROGRESS](#progress)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[SORT_ARGS & SORT_ARGS_WS](#sort-args-ws)<br>
&nbsp;&nbsp;&nbsp;&nbsp;[Bugs](#bugs)<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

## <a id="caveat">Caveat</a>

The functions and scripts are written in the bash scripting language, with some supporting scripts written in gawk.
The intention of this distribution is to provide, to the home user writing bash scripts, easy access to boilerplate or to capabilities not immediately available or obvious.
It is, and always will be, a work in progress.
For more advanced scripting users they provide a quick way to implement some standard scripting (boiler plate) capability.

Note: The coding is not necessarily the best or the most efficient. Therefore it is recommended that `functions.sh` not be used in a production or multi-user environment.
However, be that as it may, The functions allow one to concentrate on the purpose of a new script rather than having to duplicate common requirements.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

## <a id="installation">Installation</a>

### <a id="installation-procedure">Installation Procedure</a>

The installation script `install.sh` installs the bash scripts in the directory `/usr/local/bin` except for `EXTRA-BASH-FUNCTIONS.sh` which is installed in the directory `/etc/profile.d`

Download the zipfile and extract it to an empty directory (in `/tmp`).

```bash
cd /tmp                                   # Or wherever you want
```
Then download the zipfile and continue the installation.
```bash
unzip bash-functions-main.zip             # Unzip the file
sudo /tmp/bash-functions-main/install.sh  # And install it as "root"
```

Edit the file `/usr/local/bin/MKSCRIPT` to reflect your copyright needs.

- Modify the default name:
```bash
DEFAULT_NAME="Mike Armstrong"
```

- Modify the copyright lines following the line:
```bash
# = Modify the following copyright information as appropriate. =
```

- You may want to edit the file `/etc/profile.d/EXTRA-BASH-FUNCTIONS.sh` and change the value of the environment variable `_GET_ARGS_GLOBAL_HELP_DEFAULT_` as instructed there.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

### <a id="required-packages">Required Applications</a>

The following linux applications are required for full functionality.

| PACKAGE | REQUIREMENT |
|--|--|
| bash    | Required |
| gawk    | Required |
| nmap    | Only if you use the network functions |
| yad     | Only if you use the -G (GUI) option in any functions |
| sort    | Only if you use the functions `SORT_ARGS` and `SORT_ARGS_WS` |

if you don't have `gawk` then a symbolic link to awk will work as well:

    sudo ln -s /usr/bin/awk /usr/bin/gawk

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

# <a id="summary">Summary of the Major Functions and Variables within `functions.sh`</a>

The following is a description of the functions and variables in `functions.sh` that are most likely to be used.

## <a id="major-functions">Major Functions</a>

| MAJOR FUNCTIONS             | DESCRIPTION |
|--|--|
| GET_ARGS                    | Parses parent script options and arguments and provides man-page like help. Described in more detail below. |
| IS_EXCLUSIVE                | Detects and manages combinations of parent script options when the parent script is executed as a command. Described in more detail below. |
| USAGE, ERROR, WARNING       | A set of functions to manage error or warning parent script messages. |
| ASK, ASK_GUI                | Manages parent script questions and validates the answers. Described in more detail below. |
| ASK_WITH_MENU, ASK_WITH_MENU_GUI | Same as `ASK` but presents a menu of choices and accepts single or multiple answers. Described in more detail below. |
| IS_ROOT, IS_NUMERIC, IS_... | A set of testing functions. for example `IS_ROOT` returns TRUE if the parent script is running with root privileges. |
| TEST_...                    | A set of functions and variables that can be used while testing the parent script to surround commands that make a (critical) 'change'. Executing the parent script with the option `-t` or `--test` will cause those commands to be displayed (after all expansions) rather than being executed. |
| SORT_ARGS, SORT_ARGS_WS     | Functions that sorts the arguments to the function and display the sorted result. |
| TMP_FILE_..., TMP_DIR_...   | A set of functions to manage creation and deletion of temporary files and directories. |
| cleanup operations          | Upon parent script exit, `functions.sh` automatically deletes any temporary files/directories created by the TMP_... functions and unmounts any filesystems mounted by functions in `functions.sh`. |
| Many other functions...     | Many other uses... |

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

## <a id="major-global-variables">Major Global Variables</a>

Some of the many variables available for use by the parent script.

| VARIABLE            | DESCRIPTION |
|--|--|
| Opt_XXX             | A variable set by `GET_ARGS` for an option parsed from the command line when the parent script is executed. `Opt_XXX` contains the number of times a particular option is encountered. |
| Opt_XXX_Val[*]      | An array containing the option values for any option `Opt_XXX` requiring a value. |
| Opts_All            | A variable containing every option encountered (in order but with no values). |
| Args[*]             | An array (origin 1) containing all the arguments encountered when the parent script is executed. |
| CMD                 | The basename of the executing parent script. |
| CMD_DIR             | The directory that contains the parent script |
| ANSWER...           | A (set of) variables containing the response(s) entered by the user when the ASK function is invoked. |
| BLK, RED, GLD, etc. | Variables that can be used to color and format messages displayed by 'echo -e'. The function `COLORS_DISPLAY` displays the colors implemented. |

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

# <a id="documentation">Documentation</a>

All the scripts are self documenting as they all use `GET_ARGS` to define and display options and arguments.
And all the functions are preceded by documentation describing the function usage.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

## <a id="script-documentation">Script Documentation</a>

`functions.sh` is self documenting.
Assuming `functions.sh` was installed in a directory listed in `PATH` (/usr/local/bin), then typing:

```bash
functions.sh
```

displays the complete help for every function and variable.
The display is paged with 'less'.  
The first page displays the purpose of `functions.sh` followed by the suggested coding to implement `functions.sh` that should be entered into the environment and at the beginning of a parent script.

```bash
functions.sh FUNCTION              # Displays the documentation for `FUNCTION`
```

To use the functions and variables within a parent script, include the following lines (`functions.sh` self help    displays complete instructions on how to do this):

```bash
# Initialize functions.sh if preloaded into the environment. Otherwise locate and load functions.sh
if (( _functions_sh_loaded_ )) ; then           # Is functions.sh loaded?
  FUNCTIONS_SH_INIT                             # Initialize functions.sh
else                                            # functions.sh not loaded
  COMMON_FUNCTIONS="$(type -p functions.sh)"    # Locate and load functions.sh
  [[ -x ${COMMON_FUNCTIONS} ]] && source "${COMMON_FUNCTIONS}" || { echo -e "Cannot locate "${COMMON_FUNCTIONS:-functions.sh}"." 1>&2 ; exit ; }
fi

```

The script `MKSCRIPT` [(see MKSCRIPT below)](#mkscript) automatically adds the lines above.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

### <a id="mkscript">MKSCRIPT</a>

The script MKSCRIPT creates a script file containing the  lines recommended for a parent script. It also sets execute permission on the created script.  
Try the following examples:

```bash
MKSCRIPT My_Script           # Creates the script My_Script with execute permission.
                             # My_Script contains the code to implement functions.sh,
                             # a copyright notice and a small sample of GET_ARGS.
```
```bash
MKSCRIPT -H                  # Displays help for MKSCRIPT (paged with less)
```
```bash
MKSCRIPT -h                  # Displays help for MKSCRIPT (not paged)
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

### <a id="find-functions">FIND-FUNCTIONS</a>

The bash script `FIND-FUNCTIONS` displays the function source code or the documentation for a single function (or a set of functions matching a PATTERN) in `functions.sh`.
However it also can be used for any script that has a recognizable PATTERN for documentation.
It assumes `functions.sh` is installed in the directory /usr/local/bin.
To see the options available for `FIND-FUNCTIONS` type:

```bash
FIND-FUNCTIONS --HELP
```

An example of `FIND-FUNCTIONS` usage:

```bash
FIND-FUNCTIONS -c TRIM         # Shows the documentation (comments) paged with "less"
                               # for the `TRIM` function in functions.sh
```
To get a list of all the functions available in `functions.sh`, type:

```bash
FIND-FUNCTIONS --ns -f -l "[^_].*"    			# The pattern "[^_].*" eliminates internal (reserved) functions
```

THe same command as above but using long options.

```bash
FIND-FUNCTIONS --no-separator --function-names-only --less "[^_].*"
```


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

### <a id="extra-bash-commands">EXTRA-BASH-FUNCTIONS.sh</a>

This script contains useful functions that `install.sh` copies to the directory `/etc/profile.d`.
Thus they are always available at the command line in a terminal session and can be typed as commands.

Full documentation of `EXTRA-BASH-FUNCTIONS.sh` can be viewed by:

```bash
FIND-FUNCTIONS -c -s /etc/profile.d/EXTRA-BASH-FUNCTIONS.sh
```
Three extra functions are available:

| FUNCTION     | DESCRIPTION |
|--|--|
| FUNCTIONS    | Typing this at a command line loads `functions.sh` into your current environment. It also turns off bash debugging (set +x) and sets all `exit` statements in `functions.sh` to be `return` thus preventing any error exits from closing your terminal session. |
| HIGHLIGHT    | A complex grep command that highlights, in a script, salient functions and arguments related to the major functions `GET_ARGS` and `IS_EXCLUSIVE` in this distribution.<br>&nbsp;&nbsp;&nbsp;&nbsp;Usage: `HIGHLIGHT [ path-to-script ]`<br>Where: path-to-script defaults to `/usr/local/bin/FIND-FUNCTIONS` |
| RUNME        | A function that executes any function in `functions.sh` (or another function library) in a safe environment and displays the result(s). |

For example, documentation of function `RUNME` in `EXTRA-BASH-FUNCTIONS.sh` can be viewed by:

```bash
FIND-FUNCTIONS -c -s /etc/profile.d/EXTRA-BASH-FUNCTIONS.sh RUNME
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

## <a id="function-documentation">Function Documentation</a>

### <a id="GET_ARGS">GET_ARGS</a>

`GET_ARGS` is the primary function in this distribution.
It has three basic purposes:

1. Define the parent script's allowable options and arguments (with GET_ARGS_OPTIONS).
2. When the parent script is executed, GET_ARGS parses the options and arguments supplied on the command line based upon the instructions of the GET_ARGS_OPTIONS. The parsed results are made available to the parent script in a deterministic form.
3. Format and display a manpage-like USAGE (help) for the parent script.

`GET_ARGS` functionality is summarized as follows:

| GET_ARGS FEATURES |
|--|
| Options available to the parent script are defined with the GET_ARGS_OPTION pair `--Opt_D "..."` and `--Des_D "..."`.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(`--Option_Definition` and `--Description_Definition`). |
| Each defined option has a description that specifies the purpose of that option.<br>The description is formatted and displayed in the help display.
| Options can be single character `-a` or multiple character `--all`. |
| Any option can be defined to have several spellings (`-a` and `--all` and ...). |
| Any option can be defined (and enforced) with: no, a required or an optional value. |
| Multiple occurences of an option can be specified ( `-x abc -x def -x ghi`) |
| When the parent script is invoked the options and arguments can be specified in any order. |
| Arguments are collected into an array `Args[*]` (origin 1). |
| The number of options or arguments can be defined (and enforced). Vis: `--Opts_Min 1`, `--Args_Req 3` ... |
| Options `-h` `--help` `-H` `--HELP` `-v` `--version` `-t` `--test` are automatically implemented. |
| The USAGE display (help) is generated from the GET_ARGS_OPTIONS. |
| For help when the parent script is invoked, three display formats are available: normal, compact/expand and brief. |
| Help output is divided into sections. GET_ARGS_OPTIONS can be used to create text in each section in addition to the text generated automatically.<br>E.G. `--Para "..."` inserts a paragraph, `--Example "..."` creates an EXAMPLE section. |
| Help output is automatically folded and properly indented (usually) to fit ${COLUMNS} wide.
| Help output can be filtered to only display portions of the complete help output. |
| Also functions USAGE, ERROR and WARNING compliment option processing. |
| GET_ARGS can save the results of parsing the GET_ARGS_OPTIONS and restore them at subsequent invocations of the parent script. This can save a few milliseconds of CPU time for scripts that have a lot of options. |

Full documentation of `GET_ARGS` (it is extensive) can be viewed by:

```bash
FIND-FUNCTIONS --comments --less GET_ARGS
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

### <a id="IS_EXCLUSIVE">IS_EXCLUSIVE</a>

This function is a "daughter" to GET_ARGS and can only be called after GET_ARGS has been invoked. It's purpose is to create rules that validate allowed combinations of command-line options when a parent script is executed.
When an `IS_EXCLUSIVE` rule is violated, an error message summarizing the problem is displayed and the parent script is exited.

Basic `IS_EXCLUSIVE` functionality is summarized as follows:

| IS_EXCLUSIVE FEATURES |
|--|
| Verify that in a set of options only one option may be specified. |
| Verify that a set of options must be used together. |
| Verify that an option cannot be used with any other option. |
| Verify that an option must be paired with any of a list of options.
| Verify that an option must not be paired with any of a list of options.
| Supply a default option if none of a list of options is specified. |
| Verify the allowed number of times an option may be used on the command line. |
| Additional more specific capabilities are also available.  |

Full documentation of `IS_EXCLUSIVE` can be viewed by:

```bash
FIND-FUNCTIONS -c -l IS_EXCLUSIVE
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

### <a id="ASK"><br>&nbsp;&nbsp;&nbsp;&nbsp;ASK, ASK_GUI, ASK_WITH_MENU, ASK_WITH_MENU_GUI</a>

The basic functionality of the set of `ASK` functions is to display statements or questions to a user and to record the response.
A response can be verified against a set of acceptable responses.
The `ASK` functions loops until a correct response is entered or a `quit` is requested.
The first argument to `ASK` is required.
It specifies either the type of response or the type of response and a default list of choices.

`ASK` functionality is summarized as follows:

| ASK FEATURES |
|--|
| Expected response types can be: yes or no, a number, an alphabetic character (UPPER CASE, lower case or mixed case), a range, a word, a phrase or anything at all, |
| `ASK` verifies the response matches the type (or is one of the choices). |
| If it is not, `ASK` displays an error message and re-prompts for an answer. |
| `ASK` always recognizes a "quit" response (usually "q") that exits the parent script or return with an error code. |
| You can configure `ASK` to have a default result inserted for a null (empty) response. |
| By default the response is placed in the variable ANSWER. The variable name can be changed.
| Multiple responses can be configured in which case the responses are placed in the array ANSWER. |
| `ASK` has a GUI capability. The display/response takes place in a dialog box. |
| `ASK_WITH_MENU` is an extension where the "questions" are elements of an array. The elements become the choices available. |
| The array can be an indexed array, an associative array or arguments to `ASK_WITH_MENU`. Either array can be "sparse" I.E. have noncontiguous elements. |
| `ASK_WITH_MENU` creates a numbered menu from the array elements and waits for a response. |
| Like `ASK`, `ASK_WITH_MENU` can be configured to accept multiple responses and there is always a "quit" response. |
| The results are placed in three arrays: ANSWER, ANSWER_IDX and ANSWER_VAL. The default prefix "ANSWER" can be changed. |
| The `ASK` functions can be executed with a GUI interface using `yad` to implement dialog boxes. |

Full documentation of the set of `ASK` functions can be viewed by:

```bash
FIND-FUNCTIONS -c -l "ASK.*"
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

## <a id="TMP_FILE_CREATE">TMP_FILE_CREATE et al.</a>

Several functions manage temporary files and directories.
Any files or directories created are automatically deleted when the parent script terminates.
Unless directed otherwise, the files/dirs are created in `/tmp`.  
The functions are summarized below.

| FUNCTION | Description |
| -------- | ----------- |
| TMP_FILE_CREATE | Create a file with a unique name and assign that name to a bash variable. |
| TMP_FILE_PERMANENT | Like TMP_FILE_CREATE but the file is not deleted at parent script termination. |
| TMP_FILE_DELETE | Delete a created file. |
| TMP_DIR_CREATE | Create a directory with a unique name and assign that name to a bash variable. |
| TMP_DIR_PERMANENT | Like TMP_DIR_CREATE but the directory is not deleted at parent script termination. |
| TMP_DIR_DELETE | Delete a created directory. |

To see the documentation for TMP_FILE_CREATE type:

```bash
functions.sh TMP_FILE_CREATE                # Display help for the function TMP_FILE_CREATE
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

## <a id="tryme">Examples of Functions</a>

Once installation is complete either open another terminal session or type the following:

```bash
source /etc/profile.d/EXTRA-BASH-FUNCTIONS.sh
```

There are two ways you can practice using the functions.
The better way is to use the RUNME function as it also displays the result(s) from executing a function.

```bash
RUNME <FUNCTION_AND_ARGUMENTS>     # The preferred way
```

RUNME creates a sub-shell, loads `functions.sh` into it, runs the function and attempts to display the contents of the variable(s) created (if any).
You can freely experiment, in an initialized environment, at the command line with the functions made available.
RUNME can also turn on bash debugging (-x) so the function can be tested.

Or, slightly less useful, by loading `functions.sh` into your environment:

```bash
FUNCTIONS                          # load `functions.sh` into your environment and set every "exit" to a "return".
```
```bash
<FUNCTION_AND_ARGUMENTS>           # Execute the function
```
```bash
echo <VARIABLES_CREATED>           # Display the created variables
```

The function `FUNCTIONS` "sources" `functions.sh` and calls the function `USAGE_RETURN` (wow this sentence is certainly **_function_**al).
This changes any `exit` commands to be the command `return` so your terminal session is not closed when an error occurs.
Now you can freely experiment at the command line with the functions made available.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

#### <a id="example-of-get-args">Example of GET_ARGS and IS_EXCLUSIVE</a>

To see how `GET_ARGS` and `IS_EXCLUSIVE` works and to see some other features we will use the `FIND-FUNCTIONS` and `HIGHLIGHT` commands.

#### <a id="example-of-help">Example of help implemented by GET_ARGS</a>

Before you look at an example of the coding for `GET_ARGS`, see how help is implemented by `GET_ARGS`.
We will use help for `FIND-FUNCTIONS` and to see how it works. Try the following:

```bash
FIND-FUNCTIONS -h              # This displays the help text.
````
```bash
FIND-FUNCTIONS -H              # So will this paged with "less".
```
```bash
COLUMNS=70 FIND-FUNCTIONS -H   # Simulate a 70-column terminal. The folding is (almost) perfect.
```
```bash
FIND-FUNCTIONS --HELP=c        # An example of compressed and paged output (or use "-Hc").
```
```bash
FIND-FUNCTIONS -hb             # Brief (not paged) help displaying: purpose, synopsis and options.
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

#### <a id="coding-of-get-args">Sample Code for GET_ARGS and IS_EXCLUSIVE</a>

Now look within the script `FIND-FUNCTIONS` to see the coding that generated the help that was displayed.
The `HIGHLIGHT` command invokes a rather complex egrep pattern that displays and highlight how `functions.sh` is used within `FIND-FUNCTIONS`.
The table below gives a brief description of the highlighted words.

So type:

```bash
HIGHLIGHT FIND-FUNCTIONS           # Highlight stuff
```
```bash
FIND-FUNCTIONS --highlight         # This is the same as above as I created a hidden
                                   # option for FIND_FUNCTIONS to highlight itself.
```
```bash
vim /usr/local/bin/FIND-FUNCTIONS  # Look at the code if you want
```

The highlighted words are described (briefly) as follows:

| &nbsp;&nbsp;LINE&nbsp;#&nbsp;&nbsp; | HIGHLIGHTED TEXT       | DESCRIPTION |
| :--: |--|--|
|  | Note 1:                      | The GET_ARGS function requires arguments. These are known as GET_ARGS_OPTIONS. They define the options allowed when executing `FIND-FUNCTIONS`. |
|  | Note 2:                      | To make it easier to see the GET_ARGS_OPTIONS, each is on a separate line and each line ends with the line continuation characters " \\". |
|  | Note 3:                      | To help explain the highlighted code, I have added the line continuation characters " \\" at the end of some comments so they are included in the displayed output. |
| 4 | SCRIPT_PURPOSE              | A variable that summarizes what the script does. The value is displayed in the help output. |
| 6 | SCRIPT_VERSION              | The value of this variable is displayed if the script is invoked with option -v or --version. |
| 7-12 | Load and/or Initialize   | The bash coding that ensures `functions.sk` is loaded and/or initialized. |
| 10 | COMMON_FUNCTIONS           | Variable containing the pathname of `functions.sh`. |
| 17-51 | GET_ARGS coding         | The call to the GET_ARGS function. The following highlighted lines are GET_ARGS_OPTIONS.|
| 17 | --Args_Array               | Instructs GET_ARGS to create an array `Args` which contains the `FIND-FUNCTIONS` non-option arguments found. |
| 18 | --Copyright                | Causes the default copyright notice to be inserted into the help text. |
| 19-40 | --Opt_D and --Des_D     | Defines and describes the `FIND-FUNCTIONS` options allowed. |
| 29 | --Hid_D                    | Is like --Opt_D in that it defines a parent script option (--list or --ListOptions) but it is is not displayed by help. |
| 29 | ${CMD}                     | `functions.sh` creates this variable with basename of the parent script name ad the value. (Other useful variables are created as well.) |
| 41-46 | --Where and --Info      | Provide extra information in the help display. |
| 47-50 | --Exam                  | Creates an EXAMPLE section. |
| 51 | -- "$@"                    | These two arguments always must be the last of the GET_ARGS arguments. |
| 55-64 | IS_EXCLUSIVE            | A function that defines rules for acceptable combinations of parent script options. |
| 70 | Opt_list                   | Is a variable created if the parent script is invoked with the option --list or --ListOptions.
| 70 | Opt_list_Val               | Is the (optional) value created by using the syntax --list=VALUE or --ListOptions=VALUE.
| 70-105 | Opt_X, Opt_XXX         | When executing `FIND-FUNCTIONS` these variables are created (incremented) each time option -X or --XXX is encountered on the command line. I.E. If Opt_X tests TRUE then option -X was used. |
| 70-105 | Opt_X_Val, Opt_XXX_Val | At parent script execution, these variables contain the value if option -X VALUE or --XXX=VALUE is followed by a value. |
| 93 | For example:               | The line:<br>&nbsp;&nbsp;&nbsp;&nbsp;`(( Opt_E )) && TheOutputCommand="${Opt_E_Val}"`<br>is interptreterd as:<br>&nbsp;&nbsp;&nbsp;&nbsp;If -E /mybin/myeditor or --editor=/mybin/myeditor was used (I.E. Opt_E > 0) then set "TheOutputCommand" to the value "/mybin/myeditor" ( the variable Opt_E_Val contains the option value). |
| 110-117 | ${TEST_CMD}           | Causes the command line to be displayed if option --test (-t) was used. Otherwise the command is executed. Useful for testing a script. |
| 119 | IS_TESTING                | A function that returns TRUE if --test (-t) was used. |
| 122 | ERROR                     | A function that displays the error message and immediately exits `FIND-FUNCTIONS`. |

You can use `FIND-FUNCTIONS` to display the comments or functions in another script.
So, for the functions contained in the script `/etc/profile.d/EXTRA-BASH-FUNCTIONS.sh`, try:

```bash
FIND-FUNCTIONS --comments --script /etc/profile.d/EXTRA-BASH-FUNCTIONS.sh
```
or (using shorter options)
```bash
FIND-FUNCTIONS -c -s /etc/profile.d/EXTRA-BASH-FUNCTIONS.sh            # Display the comments for all functions
```

```bash
FIND-FUNCTIONS -c -s /etc/profile.d/EXTRA-BASH-FUNCTIONS.sh HIGHLIGHT  # Display the comments for the function HIGHLIGHT
```

```bash
FIND-FUNCTIONS -f -s /etc/profile.d/EXTRA-BASH-FUNCTIONS.sh            # Display just the function names for all the functions
```

```bash
FIND-FUNCTIONS -s /etc/profile.d/EXTRA-BASH-FUNCTIONS.sh               # Display the source code for all the functions
```

```bash
FIND-FUNCTIONS -s /etc/profile.d/EXTRA-BASH-FUNCTIONS.sh HIGHLIGHT     # Display the source code for the function `HIGHLIGHT`
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

#### <a id="experiment-with-ASK">Experiment with ASK</a>

The ASK function displays a question or statement and records the response in the variable `ANSWER`.
It also validates the response to determine if it is one of the acceptable choices.

Try the following `ASK TYPE` command with each of the possible response types.

| TYPE | RESPONSE EXPECTED |
|--|--|
|      | Yes or no (TYPE is missing so -yn is the default) |
| -yn  | Yes or no |
| -d   | A number |
| -a   | An alphabetic character |
| -u   | An uppercase character |
| -l   | A lowercase character |
| -w   | A word. First character alphabetic, the remainder alphanumeric and "_" |
| -c   | Any character |
| -e   | Anything at all |

```bash
# Try ASK. Enter the following replacing <TYPE> with one of the above TYPEs.
RUNME ASK <TYPE>
```

```bash
# Now, for an alphabetic response, specify a set of acceptable choices.
# Notice how to specify ranges and how the display of choices is "normalized".
RUNME ASK -a -C "A B C x-z d thru g D"
```

ASK has much more functionality. To see the full documentation type:

```bash
FIND-FUNCTIONS -c -l ASK         # Shows (with `less`) the documentation for the `ASK` function.
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

#### <a id="experiment-with-ASK-WITH-MENU">Experiment with ASK_WITH_MENU</a>

Now try ASK_WITH_MENU.
It creates a menu of choices from an array (or from the arguments) and returns three variables:

| VARIABLE     | PURPOSE |
|--|--|
| `ANSWER`     | The valid response made. |
| `ANSWER_IDX` | The index into the array (or the arg) based upon the response. |
| `ANSWER_VAL` | The value of the array element (or arg) based upon the response. |

```bash
# First a simple example using arguments.
RUNME ASK_WITH_MENU Arg1 Arg2 "This is argument 3"

# The results are displayed.
```

Now try an array.
Copy the code below and paste it into your terminal command line.
Try making an invalid choice before entering a valid one.

```bash
# Setup: Create a sparse array (one with some elements missing) and initiate with 4 elements.
unset Array ; declare -a Array
Array+=( [1]="Question1: Array index=1" )
Array+=( [9]="Question4: Array index=9" )
Array+=( [4]="Question2: Array index=4" )
Array+=( [7]="Question3: Array index=7" )
```

```bash
# Execute ASK_WITH_MENU (with a header to make it nice)
RUNME ASK_WITH_MENU -H "\n\tMake your choice\n" Array
```

The results are displayed.

Again try ASK_WITH_MENU but with an associative array (an array with non-numeric indices).
Also we will implement multiple answers.
Copy the code below and paste it into your terminal command line.
Try making an invalid choice before entering a valid one.

```bash
# Setup: Create an associative array and initiate with 5 elements (random order).
# Note:  The array elements can contain spaces.
#        However I removed them so the results display is more readable.
unset Array ; declare -A Array
Array+=( [2nd]="Question2,index=2nd" )
Array+=( [1st]="Question1,index=1st" )
Array+=( [3rd]="Question3,index=3rd" )
Array+=( [8th]="Question5,index=8th" )
Array+=( [4th]="Question4,index=4th" )
```
```bash
# Execute ASK_WITH_MENU with the results in variable QED and allowing multiple answers.
RUNME ASK_WITH_MENU -V QED -M -H "\n\tMake your choice\n" Array
```
The results are displayed.
Notice that for an associative array the order of the elements is non-determinant.

Finally try the above in a GUI environment (using -G) and with a default response (using -D).

```bash
RUNME ASK_WITH_MENU -V QED -M -D "*" -G -H "A GUI Example\n\tMake your choice\n" Array
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

## <a id="experiment-with-other-functions">Experiment with Some Other Functions</a>

There are many functions available within `functions.sh`.
The following examples show some of the capability available.

#### <a id="color">COLOR</a>

The functions related to colors are interesting. Try:

```bash
FIND-FUNCTIONS -c ".*COLOR.*"           # Display the comments (help) for the COLOR functions
```
```bash
FIND-FUNCTIONS ".*COLOR.*"              # Now display the code
```
```bash
RUNME COLORS_DISPLAY                    # See the built-in colors
```
```bash
echo -e "\nExample of 'echo' using a color: A ${UL}book${BLK} that is ${GRN}read${BLK} doesn't have to be ${RED}red${BLK}.\n"
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

#### <a id="error-warning">ERROR & WARNING</a>

Errors and warnings can be used as follows.
Note: Normal operation of `ERROR` forces immediate exit from the parent script

```bash
RUNME ERROR "This is an error message.\nThe error is..."
```
```bash
RUNME WARNING "This is a warning message.\nThe correct..."
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

#### <a id="padit-trim-zerofill">PAD_IT, TRIM & ZERO_FILL</a>

The next three functions deal with spaces and zeros surrounding a string.

```bash
FIND-FUNCTIONS -c PAD_IT TRIM ZERO_FILL |& less
```
```bash
RUNME PAD_IT -V RESULT -L 6 "abc"           # Padding left justified (the default), 6 charaters
```
```bash
RUNME PAD_IT -V RESULT -L 15 -P "HO " "Santa: "
```
```bash
RUNME PAD_IT -R -V RESULT -L 9 abc          # Padding right justified, 9 characters
```
```bash
RUNME TRIM -V RESULT  "   abc def   "       # Trim surrounding whitespace
```
```bash
RUNME TRIM -V RESULT -L "   abc def   "     # Trim (-L) the whitespace on the left
```
```bash
RUNME TRIM -V RESULT -R "   abc def   "     # Trim (-R) the whitespace on the right
```
```bash
RUNME ZERO_FILL -V RESULT -L 6 123          # Zero fill on the left
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)


#### <a id="pause">PAUSE</a>

The function `PAUSE` is a simple way to "wait and continue".

```bash
FIND-FUNCTIONS -c PAUSE               # View the documentation
```
```bash
RUNME PAUSE "\nAn easy way for the program to wait for user input before continuing.\n\t"
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

#### <a id="progress">PROGRESS</a>

The function `PROGRESS` can be used within a loop to indicate your script is 'thinking'.
It displays (on /dev/stderr) a dot "." every time it is executed.

```bash
FIND-FUNCTIONS -c PROGRESS            # View the documentation
```
```bash
FUNCTIONS                             # Load `functions.sh` into the environment
```
```bash
PROGRESS 2                            # Setup to display "." every 2 iterations
echo -n "Processing your request. Please wait: "
for (( i=1 ; i<=20 ; i++ )) ; do      # A 20-times loop
  sleep 0.5                             # Simulate "work"
  PROGRESS                            # PROGRESS without arguments implements the "." counter
done
echo -e "\nFinished."
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

#### <a id="sort-args-ws">SORT_ARGS & SORT_ARGS_WS</a>

`SORT_ARGS` acts like its name - it sorts the arguments.
The only restriction is no argument can contain whitespace.
In simple form...

```bash
RUNME SORT_ARGS ddd ggg qwqq aaa ccc bbb zzz jjj
```
Now see what happens to an argument with whitespace.
We displays the results line-by-line with -L.
```bash
RUNME SORT_ARGS -L ddd ggg qwqq aaa ccc bbb zzz "jj j"
```
The same as above but using `SORT_ARGS_WS`.
```bash
RUNME SORT_ARGS_WS -L ddd ggg qwqq aaa ccc bbb zzz "jj j"
```

Suppose you have an array of file names all of which contain a number.
And you want to sort them in reverse number order.
The function `SORT_ARGS_WS` is needed to do this as the names contain whitespace.
But be aware it is more expensive processing wise than `SORT_ARGS`.

First an explanation of the arguments to the `SORT_ARGS_WS` examples below.

| ARGUMENT | EXPLANATION |
|--|--|
| -V SORTED_NAMES | Store the result in SORTED_NAMES. |
| -A | And make it an array. |
| -S "-n -r -t- -k2,2" | Pass options to the `sort` command<br>-n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A numeric sort.<br>-r&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sort in reverse order.<br>-t-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The field separator is "-"<br>-k2,2&nbsp;Sort on the second field |
| ${FILE_NAMES_ARRAY[@]}" | The contents of the file-name array (requoted) as the remaining arguments. |

```bash
# Create the array of file names.
FILE_NAMES_ARRAY=( "my file-11" file-20 "our file-10" file-2 "new file-1.x" file-3 file-30 )
```
```bash
# The simple case. Just sort by file name.
RUNME SORT_ARGS_WS -V SORTED_NAMES -A "${FILE_NAMES_ARRAY[@]}"
```
```bash
# Now sort by the number in the name and in decreasing order.
RUNME SORT_ARGS_WS -V SORTED_NAMES -A -S "-n -r -t- -k2,2" "${FILE_NAMES_ARRAY[@]}"
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

## <a id="bugs">Bugs and Not Yet Complete<a/>

Where would Linux be if there weren't any bugs or unfinished business?

| | |
| ----------------------------------- | ------------------------- |
| GET_IP_FROM_DOMAIN | Minimum usefulness |
| GET_MATCHING_NFS_DOMAIN_IN_FSTAB | Ditto |
| GET_ALL_UNIQUE_NFS_DOMAINS_IN_FSTAB | Ditto |

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[top](#top)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[contents](#contents)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[bottom](#bottom)

<a id="bottom"><a/>
