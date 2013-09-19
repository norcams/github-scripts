#!/bin/bash

OTP=$1

owner=$2
repo=$3
user=CHANGEME

curl -H "X-GitHub-OTP: $OTP" -i -u $user -X POST https://api.github.com/repos/$owner/$repo/hooks --data @irc.json
