#!/bin/bash -eu

nocmd() {
  echo "You need $1 to run this .."
  exit 1
}

syntax() {
  echo "Usage: $0 <org> <team> <repo_name> [<repo_name>..]"
  exit 1
}

hash jq 3>/dev/null || nocmd jq
hash git-hub 2>/dev/null || nocmd git-hub
test $# -gt 2 || syntax

org=$1
shift
team=$1
shift

team_id=$(git hub teams $org --raw --json --all | jq -r '.[] | select(.name=="'${team}'") | .id')

for repo in "$@"; do
  git hub team-repo-add $team_id $repo
done

