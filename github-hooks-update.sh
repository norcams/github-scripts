#!/bin/bash -eu

nocmd() {
  echo "You need $0 to run this .."
  exit 1
}

syntax() {
  echo "Simple script to mass update webhooks configuration through github API."
  echo
  echo "Usage: $0 <repos_config_file>"
  echo
  echo "<repos_config_file> is a space and newline separated list, e.g:"
  echo
  echo "user/repo1"
  echo "user/thisrepo thisrepo.json"
  echo "user/repo45"
  echo
  echo "repo1 and repo45 will use default.json, thisrepo got its own json file"
  exit 1
}

hash jq 3>/dev/null || nocmd jq
hash curl 2>/dev/null || nocmd curl
test $# -ne 0 || syntax

echo "Authenticating to Github:"
echo
echo -n "User:"
read username
echo

echo -n "Password:"
read -s password
echo
echo
echo -n "OTP:"
read otp
echo

repos="$(cat "${1}")"

for repo_config in $repos; do
  # field 1 is the repo name
  name=$(echo "${repo_config}" | awk '{ print $1 }')
  # field 2 is the json data file, if present
  jsonfile_config=$(echo "${repo_config}" | awk '{ print $2 }')
  # if jsonfile_config is null, assign default.json as jsonfile value
  jsonfile="${jsonfile_config:-default.json}"
  echo "user = ${username}:${password}" | curl -H "X-GitHub-OTP: ${otp}" -i -X POST -K - "https://api.github.com/repos/${name}/hooks" --data "@${jsonfile}"
done

