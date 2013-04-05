#!/bin/bash

owner=mozilla-servo
repo=$1
user=metajack

curl -i -u $user -X POST https://api.github.com/repos/$owner/$repo/hooks --data @irc.json
