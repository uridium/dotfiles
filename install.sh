#!/bin/bash

curl -sL https://github.com/uridium/dotfiles/archive/master.tar.gz | tar zx --transform 's/-master//'
cd dotfiles
./setup.sh install
