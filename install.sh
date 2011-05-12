#!/bin/sh

if [ ! -d /usr/local/etc/bash-completion.d ]; then
    echo "created /usr/local/etc/bash-completion.d"
    mkdir -p /usr/local/etc/bash-completion.d
fi

current_dir=`pwd`

# /usr/local/etc/bash-completion.d 以下に管理しているファイルのシンボリックリンクを貼る。
# なお、指定したリンクファイルがすでにあった場合は、上書きするかどうか問い合わせを行い、
# 上書きする場合には、.orig という suffix でファイルのバックアップを作成する。
echo "Make links for git-bash-completion"
find $current_dir -name 'git-*' -exec ln -sbi --suffix=.orig {} /usr/local/etc/bash-completion.d/ \;

bashrc="/etc/bashrc"
echo "# git completion" >> $bashrc
echo "if [ -f /usr/local/etc/bash-completion.d/git-completion.bash ]; then" >> $bashrc
echo "    source /usr/local/etc/bash-completion.d/git-completion.bash" >> $bashrc
echo "fi" >> $bashrc
echo >> $bashrc
echo "# git-flow completion" >> $bashrc
echo "if [ -f /usr/local/etc/bash-completion.d/git-flow-completion.bash ]; then" >> $bashrc
echo "    source /usr/local/etc/bash-completion.d/git-flow-completion.bash" >> $bashrc
echo "fi" >> $bashrc
echo >> $bashrc
echo "# Current Git Branch in Bash Prompt" >> $bashrc
echo "parse_git_branch() {" >> $bashrc
echo "  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git::\1)/'" >> $bashrc
echo "}" >> $bashrc
echo "export PS1='\[\033[00m\]\u@\h\[\033[01;34m\] \w \[\033[31m\]\$(parse_git_branch)\[\033[00m\]$\[\033[00m\] '" >> $bashrc
