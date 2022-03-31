#!/bin/bash
#
# publish-helm-chart.sh
# Upload helm package to chart repository. 
#
# Requires:
#  - helm
set -e 

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <package> <repo-configuration-json>"
	exit 1
fi

PACKAGE="$1"
CONFIG="$2"
for entry in $(echo "${CONFIG=" | jq -r '.[] | @base64'); do
  _jq() {
    echo ${entry} | base64 --decode | jq -r ${1}
  }
  url=$(_jq '.url')
  user=$(_jq '.user')
  password=$(_jq '.password')
  type=$(_jq '.type' | sed "s/null//")
  scheme=$(echo ${url} | sed -E 's|(https?://).+|\1|')
  hosturl=$(echo ${url} | sed -E 's|https?://(.+)|\1|')

  for file in ${PACKAGE}-*.tgz; do
    echo "Uploading: ${file} to: ${url}"
    case $type in 
      nexus)
        curl --silent -u ${user}:${password} ${url} --upload-file ${file}
        ;;
      *)
        curl --silent --data-binary "@${file}" "${scheme}${user}:${password}@${hosturl}"
        ;;
    esac
  done
done