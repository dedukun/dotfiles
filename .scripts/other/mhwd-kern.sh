#!/usr/bin/env bash
# mhwd-kern.sh written by handy with some python help from Joshua.
#
# 6-March-2014: Joshua made his much appreciated python contribution work
# great, allowing me to release this little beast into the wild!
#
# 5-March-2014: Have improved the effecticiency (I think I coined a new
# word! lol) of the script, doing away with the need to cut & paste anything.
# Joshua showed me the trick.
##########################################################
# 4-March-2014: Created mhwd-kern.sh - a simple bash script that creates
# a menu with the mhwd-kernel options listed. Once you have made your
# choice from the menu's options, you enter the number [?] of your chosen
# option into the terminal & hit Enter, which will take you to the next
# step(s) to complete your chosen task.
# If you don't want to make a choice hitting Enter will terminate the script.
###########################################################

err() {
   ALL_OFF="\e[1;0m"
   BOLD="\e[1;1m"
   RED="${BOLD}\e[1;31m"
    local mesg=$1; shift
    printf "${RED}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

msg() {
   ALL_OFF="\e[1;0m"
   BOLD="\e[1;1m"
   GREEN="${BOLD}\e[1;32m"
    local mesg=$1; shift
    printf "${GREEN}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

#-----------------------------------------------------
# Python shit = python FUNCTION - from Joshua follows:
#-----------------------------------------------------

function input {
   python2 -c 'import sys,readline;readline.set_startup_hook(lambda: readline.insert_text(sys.argv[2]));sys.stderr.write(raw_input(sys.argv[1]))' "$@" 3>&1 1>&2 2>&3
}

#----------------------------------------------------------------
# The above was it, now we wrangle with it below, somewhere...
#----------------------------------------------------------------

# The menu:

clear # Clear the screen.

echo
echo -e "\e[1;32m                             mhwd-kern.sh "
echo
echo -e " \e[0;33m   Enter Your chosen Option's number \e[0;32m[\e[1;37m?\e[0;32m] \e[4;37mOR\e[0m\e[0;32m hit \e[0;31mReturn\e[0;32m to \e[0;31mexit\e[0;32m. "
echo
echo
echo -e "    [\e[1;37m1\e[0;32m]\e[0;32m List available Manjaro Kernels: \033[0m mhwd-kernel -l "
echo
echo -e "   \e[0;32m [\e[1;37m2\e[0;32m]\e[0;32m List installed Kernels: \033[0m mhwd-kernel -li "
echo
echo -e "   \e[0;32m [\e[1;37m3\e[0;32m]\e[0;32m Install new kernel(s): Add a valid linux kernel number "
echo -e "    directly after \e[1;37mlinux\e[0;32m \e[0;33m(no space)\e[0;32m to the following command, "
echo -e "    where you can also choose to add (as shown in the "
echo -e "    following example) multiple kernels (always separated by "
echo -e "    a space): \033[0m sudo mhwd-kernel -i \e[1;37mlinux\033[0m linux313 linux312\033[0m "
echo
echo -e "   \e[0;32m [\e[1;37m4\e[0;32m] Remove one or more installed kernels: (leave at "
echo -e "    least one!). The following example has both the \e[0;33m34\e[0;32m & \e[0;33m311\e[0;32m "
echo -e "    kernels included: \033[0m sudo mhwd-kernel -r linux\e[0;33m34\033[0m linux\e[0;33m311 "
echo
echo -e "   \e[0;32m [\e[1;37m5\e[0;32m] Remove currently running kernel & install those "
echo -e "    specified: \033[0m sudo mhwd-kernel \e[0;33m<add kernel(s) here> \e[0;31mrmc\e[0;32m "
echo -e "    \e[0;33mNote: \e[0;32mthe \e[0;31mrmc\e[0;32m option is essential to this command. "
echo
echo -e "   \e[0;32m [\e[1;37m6\e[0;32m] Display the mhwd-kernel help output in "
echo -e "    the terminal: \033[0m mhwd-kernel -h "
echo
echo -e "\033[1m  Enter the Number of Your Choice: \033[0m"
echo

read option

case "$option" in
# Note variable is quoted.

 "1")
 echo
 msg "Currently Available Manjaro Kernels: "
 echo
 mhwd-kernel -l
 echo
 #mhwd-kern.sh
 ;;
# Note double semicolon to terminate each option.

 "2")
 echo
 msg "Kernels currently installed on this machine: "
 echo
 mhwd-kernel -li
 echo
 #mhwd-kern.sh
 echo
 ;;
# Note double semicolon to terminate each option.

 "3")
 echo
 msg "Kernel Installation"
 echo
 echo -e "\e[0;32m    Enter the Kernel number directly after \e[1;37mlinux\e[0;32m & hit Enter: \033[0m "
 echo
 printf "sudo mhwd-kernel -i \e[1;37mlinux\033[0m"
 read versionNumber
 echo
 echo -e "\e[0;32m    Input sudo password & hit \e[0;31mEnter\e[0;32m to install following kernel: \033[0m "
 echo
 printf "sudo mhwd-kernel -i linux$versionNumber \n"
 echo
 sudo mhwd-kernel -i linux$versionNumber
 exit 0
 echo
 ;;
# Note double semicolon to terminate each option.

 "4")
 echo
 msg "Remove one or more kernels:"
 echo
 echo -e "\e[0;32m    To remove one Kernel, enter the number of the kernel "
 echo -e "    you wish to remove after \e[1;37mlinux\e[0;32m & hit Enter. "
 echo -e "    Remove multiple kernels, (separate with a space) as follows: "
 echo -e "    e.g.\033[0m sudo mhwd-kernel -r \e[0;33mlinux34 linux310 \033[0m "
 echo
 printf "sudo mhwd-kernel -r \e[1;37mlinux\033[0m"
 read versionNumber
 echo
 echo -e "\e[0;32m    Input sudo password & hit \e[0;31mEnter\e[0;32m to \e[0;31mRemove\e[0;32m the following kernel(s): \033[0m "
 echo
 printf "sudo mhwd-kernel -r linux$versionNumber \n"
 echo
 sudo mhwd-kernel -r linux$versionNumber
 exit 0
 echo
 ;;
# Note double semicolon to terminate each option.

 "5")
 echo
 msg "Remove currently running kernel & install one or more new kernels:"
 echo
 echo -e "\e[0;32m    This command \e[0;31mRemoves\e[0;32m the kernel you booted with. "
 echo -e "    It is also used to \e[0;33mInstall\e[0;32m one or more kernels by adding "
 echo -e "    them to the command below. "
 echo -e "    You add multiple kernels, (separated by a space) as follows: "
 echo -e "    e.g.\033[0m sudo mhwd-kernel -i \e[0;33mlinux34 linux310 rmc\033[0m "
 echo
 versionNumber=$( input 'sudo mhwd-kernel -i ' 'linux rmc')
 echo
 echo -e "\e[0;32m    Input your sudo password & hit \e[0;31mEnter\e[0;32m to \e[0;31mRemove\e[0;32m the current "
 echo -e "    kernel, & to \e[0;33mInstall\e[0;32m the kernel(s) you just chose: \033[0m "
 echo
 printf "sudo mhwd-kernel -i $versionNumber\n"
 echo
 sudo mhwd-kernel -i $versionNumber
 exit 0
 echo
 ;;
# Note double semicolon to terminate each option.

 "6")
 echo
 msg "Following is the output of the mhwd-kernel -h command: "
 echo
 mhwd-kernel -h
 echo
 ;;
# Note double semicolon to terminate each option.

esac

exit 0
