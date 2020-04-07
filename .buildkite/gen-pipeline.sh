#!/usr/bin/env bash

set -e
cd $(dirname "${BASH_SOURCE[0]}")/..

go get gopkg.in/yaml.v2
go run ./.buildkite/gen-pipeline.go
