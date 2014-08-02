#!/bin/bash

mkdir /home/vagrant/go
wget -P /home/vagrant/ http://golang.org/dl/go1.3.linux-amd64.tar.gz

GO_MD5SUM = "b6b154933039987056ac307e20c25fa508a06ba6"

sudo tar -xzf go1.3.linux-amd64.tar.gz

export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin
