#!/bin/bash -eu

nocmd() {
  echo "You need $1 to run this .."
  exit 1
}

syntax() {
  echo "Usage: $0 <github user/org>"
  exit 1
}

hash jq 2>/dev/null || nocmd jq
hash git-hub 2>/dev/null || nocmd git-hub
test $# -ne 0 || syntax

git hub repos --raw --json --all ${1} | jq -r '.[] .full_name'

