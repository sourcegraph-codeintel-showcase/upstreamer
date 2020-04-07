#!/usr/bin/env bash

set -e

OWNER="${1:?missing owner}"
NAME="${2:?missing name}"

git clone https://github.com/sourcegraph-codeintel-showcase/$NAME.git
pushd "$NAME"
git remote add upstream https://github.com/$OWNER/$NAME.git
git fetch upstream master
git rebase upstream/master master
GIT_SSH_COMMAND='ssh -i /buildkite/.ssh/codeintel_showcase_upstreamer -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no' git push origin master --force
popd
