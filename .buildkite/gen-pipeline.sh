#!/usr/bin/env bash

set -e
cd $(dirname "${BASH_SOURCE[0]}")/..

go run ./.buildkite/gen-pipeline.go
