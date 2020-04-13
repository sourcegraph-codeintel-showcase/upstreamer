#!/usr/bin/env bash

set -ex

OWNER="${1:?repository owner not supplied}"
NAME="${2:?repository name not supplied}"

git clone "git@github.com:sourcegraph-codeintel-showcase/$NAME.git"
pushd "$NAME"

# Fetch upstream changes
git remote add upstream git@github.com:$OWNER/$NAME.git
git fetch upstream master

# Set git identity for following rebase command
git config user.name "Codeintel showcase upstreamer"
git config user.email "codeintel-showcase-upstreamer@sourcegraph.com"

# Re-apply LSIF upload commit
git rebase upstream/master master

# Push n+1 commits to the showcase repository
# This requires a special private key on the buildkite agents
GIT_SSH_COMMAND="ssh -i /buildkite/.ssh/codeintel_showcase_upstreamer.$NAME -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" \
    git push origin --force

popd
