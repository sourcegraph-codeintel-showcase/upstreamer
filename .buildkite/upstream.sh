#!/usr/bin/env bash

set -e

OWNER="${1:?missing owner}"
NAME="${2:?missing name}"

git clone https://github.com/sourcegraph-codeintel-showcase/$NAME.git
pushd "$NAME"
git remote add upstream https://github.com/$OWNER/$NAME.git
git fetch upstream master
git rebase upstream/master master
git push origin master --force
popd
