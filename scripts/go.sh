#!/bin/bash

mkdir /home/vagrant/go
wget -P /home/vagrant/ http://golang.org/dl/go1.3.linux-amd64.tar.gz

sudo tar -xzf go1.3.linux-amd64.tar.gz

export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin
