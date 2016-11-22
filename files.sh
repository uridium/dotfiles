#!/bin/bash

function usage {
    echo "Usage: $0 {install|rollback}"
    exit 1
} >&2

function reconfig {
    source $HOME/.bashrc
}

files=".bashrc .gitconfig .gitignore .inputrc .mongorc.js .my.cnf .psqlrc .screenrc .toprc .vimrc .vim"
conf=$(pwd)
oldconf=$HOME/.dotfiles.old

case "$1" in
    install)
        test -d $oldconf || mkdir $oldconf

        for i in $files; do
            test -L $HOME/$i || mv $HOME/$i $oldconf/
            ln -fs $conf/$i $HOME
        done

        reconfig
        ;;
    rollback)
        for i in $files; do
            test -L $oldconf/$i || rm -rf $HOME/$i && mv $oldconf/$i $HOME/
        done

        test -d $oldconf && rmdir $oldconf
        reconfig
        ;;
    *)
        usage
        ;;
esac

exit 0
