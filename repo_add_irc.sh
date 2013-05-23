#!/bin/bash

owner=$1
repo=$2
user=CHANGEME

curl -i -u $user -X POST https://api.github.com/repos/$owner/$repo/hooks --data @irc.json
