#!/bin/bash

export GODIR
git clone git@github.com:nektos/act.git
cd act
make install

cd $GODIR

