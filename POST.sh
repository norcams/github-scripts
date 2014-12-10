#!/bin/bash

user=$1
OTP=$2

owner=$3
repo=$4

curl -H "X-GitHub-OTP: $OTP" -i -u $user -X POST https://api.github.com/repos/$owner/$repo/hooks --data @${owner}_${repo}.json

