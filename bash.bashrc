shopt -s histappend
shopt -s histverify
shopt -s expand_aliases
shopt -s cdable_vars


#history is set to unlimited. Change accsavedcmdsg to your need. Also
#change history format if you dont it

export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%F %r ❘ "
export HISTFILESIZE=
export HISTSIZE=


#setting nano as default editor

export VISUAL="nano"
export EDITOR="nano"


#prompt command to better history

PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
PROMPT_DIRTRIM=5

#simple prompt

PS1="\[\033[0;32m\]┌──[\[\033[0;1m\]\w\[\033[0;32m\]]
\[\033[0;32m\]└─\[\033[0;32m\]➤\[\033[0m\] "



if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
	command_not_found_handle() {
		/data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
	}
fi


#--------------------------------------------------------


#--------------------------------------------------------

#function before setting aliases for accessing original commands


#opens gdu ui mode (install pkg gdu)

function gduui () {

	gdu -a ;

}




#updated wget (install pkg wget2)

function wget () {
	wget2 "$@" ;
}

#going n times back in directory 
up ()
{
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}



#--------------------------------------------------------

#aliases (install pkgs bat, gdu, exa, adb, ack)


alias du="du -h -a -d 1 --apparent-size | sort -h"
alias nano="nano -l -Z -B --backupdir=/sdcard/Termux/nanoBackup"
alias showmyip="curl ipinfo.io/ip && echo && curl ipinfo.io/country && curl ipinfo.io/region && curl ipinfo.io/city && curl ipinfo.io/postal && curl ipinfo.io/org"
alias chmod="chmod -c"
alias rmall="rm -Irv"
alias rmv="rm -iv"
alias ps="ps -A --forest"
alias bathelp='bat --plain --language=help'
alias batv="bat --wrap=never --pager=never"
alias cat="batv"
alias batcat="bat --wrap=never"
alias catp="batv -p"
alias pkgse="pkg search"
alias gdu="gdu -np -a"
alias diff="colordiff"
alias ls="exa -a --icons --sort name"
alias lst="exa -T -a --icons --sort name -L 2"
alias lst1="exa -T -a --icons --sort name -L 1"
alias lst3="exa -T -a --icons --sort name -L 3"
alias lst4="exa -T -a --icons --sort name -L 4"
alias lst5="exa -T -a --icons --sort name -L 5"
alias lst6="exa -T -a --icons --sort name -L 6"
alias adbk="adb disconnect && sleep 2s && adb kill-server && echo 'adb server stopped'"
alias adbd="adb devices"
alias adbe="adb disconnect && sleep 2s && adb kill-server && sleep 1s && exit"
alias dozee="adb shell dumpsys deviceidle enabled"
alias dozeed="adb shell dumpsys deviceidle disable"
alias bashrccopy="cp '$PREFIX/etc/bash.bashrc' '/sdcard/Termux/bashrc/' && echo 'done'"
alias bashrcreplace="cp '/sdcard/Termux/bashrc/' '$PREFIX/etc/bash.bashrc' && echo bashrc replaced"
alias editbashrc="nano $PREFIX/etc/bash.bashrc"
alias viewbashrc="bat --wrap=never --language=sh $PREFIX/etc/bash.bashrc"
alias dexoptjob="adb shell pm bg-dexopt-job"
alias batsh="bat --language=sh"
alias cp="cp -irv"
alias grep="grep --color=always"
alias mv="mv -iv"
alias edit="nano"
alias cd..="cd .."
alias bd='cd "$OLDPWD"'
alias dir="ls -D"

#--------------------------------------------------------

#functions

#show help in colour

function help() {
    "$@" --help 2>&1 | bathelp
}

#save command output to your internal storage/termux/savedcmds

function savetofile() {
	local cmdfull="$@" &&
	local cmdnmes="$(printf "$cmdfull" | sed -e 's/\'/'/›/g;s/ /⠀/g;s/\'-'/⚊/g;s/|/︱/g;s/_/▁/g;s/\\/⧹/g' | tr -d '*' )" &&
	local cmdnme && 
	printf -v cmdnme "%.250s" "$cmdnmes" &&
	date +%I:%M:%S-%p\ \ \ %d/%m/%Y >> /sdcard/Termux/savedcmds/"$cmdnme".txt && printf "\n$cmdfull\n\n\n\n" >> /sdcard/Termux/savedcmds/"$cmdnme".txt  && $* >> /sdcard/Termux/savedcmds/"$cmdnme".txt ; printf "\n\n\n\n____________________________________________________________\n\n\n\n" >> /sdcard/Termux/savedcmds/"$cmdnme".txt ;

}

#search packages

function pkgs () {
	pkg search "$@" && pkg show "$@" ;
}

#search history

function hist() {
	
	history | grep -i "$@" ;
}


# Automatically do an ls after each cd
cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ls --group-directories-first -A
  else
    builtin cd ~ && ls --group-directories-first -A
  fi
}


#--------------------------------------------------------

#function exports
#exporting functions, so you can use it in scripts

export -f savetofile
export -f wget
