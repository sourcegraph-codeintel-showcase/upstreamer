#!/usr/bin/env bash

set -e
cd $(dirname "${BASH_SOURCE[0]}")/..

OWNER="$1"
REPO="$2"

git clone https://github.com/sourcegraph-codeintel-showcase/$REPO.git
pushd "$REPO"
git remote add upstream https://github.com/$OWNER/$REPO.git
git fetch upstream master
git rebase upstream/master master
git push origin master --force
popd
