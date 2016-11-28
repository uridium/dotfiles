#!/bin/bash

curl -sL https://github.com/radar-aol-pl/dotfiles/archive/master.tar.gz | tar zx --transform 's/-master//'
cd dotfiles
./setup.sh install
