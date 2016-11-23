#!/bin/bash

files=".bashrc .gitconfig .gitignore .inputrc .mongorc.js .my.cnf .psqlrc .screenrc .toprc .vimrc .vim"
conf=$(pwd)
oldconf=$HOME/.dotfiles.old

function new {
    mv $HOME/$i $oldconf/
}

function old {
    rm -f $HOME/$i
    mv $oldconf/$i $HOME/
    echo "$i restored"
}

function reconfig {
    source $HOME/.bashrc
}

case "$1" in
    install)
        test -d $oldconf || mkdir $oldconf

        for i in $files; do
            if [ ! -L "$HOME/$i" ] && [ -f "$HOME/$i" ]; then
                new
            fi
            if [ ! -L "$HOME/$i" ] && [ -d "$HOME/$i" ]; then
                new
            fi
            if [ -L "$HOME/$i" ]; then
                break
            fi
            ln -s $conf/$i $HOME && echo "$i installed"
        done

        reconfig
        ;;
    restore)
        for i in $files; do
            if [ -L "$HOME/$i" ] && [ -f "$oldconf/$i" ]; then
                old
            fi
            if [ -L "$HOME/$i" ] && [ -d "$oldconf/$i" ]; then
                old
            fi
            if [ -L "$HOME/$i" ] && [ ! -f "$oldconf/$i" ]; then
                rm -f $HOME/$i
            fi
        done

        test -d $oldconf && rmdir $oldconf
        reconfig
        ;;
    *)
        echo "Usage: $0 {install|restore}" 1>&2
        exit 1
        ;;
esac

exit 0
