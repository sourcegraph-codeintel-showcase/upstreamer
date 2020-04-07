#!/usr/bin/env bash

set -ex

OWNER="${1:?missing owner}"
NAME="${2:?missing name}"

git clone "git@github.com:sourcegraph-codeintel-showcase/$NAME.git"
pushd "$NAME"
git remote add upstream git@github.com:$OWNER/$NAME.git
git fetch upstream master
git rebase upstream/master master
GIT_SSH_COMMAND='ssh -i /buildkite/.ssh/codeintel_showcase_upstreamer -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no' git push origin master --force
popd
