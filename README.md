# Upstreamer

This repository configures a [BuildKite pipeline](https://buildkite.com/sourcegraph/sourcegraph-codeintel-showcase-upstreamer/builds?branch=master) that fetches and merges upstream changes to the forks in the [Sourcegraph codeintel showcase organization](https://github.com/sourcegraph-codeintel-showcase). This pipeline is currently manually triggered to reduce the overhead of resolving merge conflicts when the upstream updates its CI configuration.

Each fork contains a series of commits on top of the upstream master that changes the continuous integration configuration to upload LSIF indexes to [sourcegraph.com](https://sourcegraph.com). All upstream changes _under_ are kept up to date.

## Forks

### GitHub Actions

- [IxJS](https://github.com/sourcegraph-codeintel-showcase/IxJS/actions?query=workflow%3A%22Index+and+upload+LSIF+data+to+sourcegraph.com%22)
- [kibana](https://github.com/sourcegraph-codeintel-showcase/kibana/actions?query=workflow%3A%22Index+and+upload+LSIF+data+to+sourcegraph.com%22)
- [kubernetes](https://github.com/sourcegraph-codeintel-showcase/kubernetes/actions?query=workflow%3A%22Index+and+upload+LSIF+data+to+sourcegraph.com%22)
- [lodash](https://github.com/sourcegraph-codeintel-showcase/lodash/actions?query=workflow%3A%22Index+and+upload+LSIF+data+to+sourcegraph.com%22)
- [moby](https://github.com/sourcegraph-codeintel-showcase/moby/actions?query=workflow%3A%22Index+and+upload+LSIF+data+to+sourcegraph.com%22)

### Travis CI

- aws/aws-sdk-go [![aws-sdk-go](https://api.travis-ci.org/sourcegraph-codeintel-showcase/aws-sdk-go.svg?branch=master)](https://travis-ci.org/github/sourcegraph-codeintel-showcase/aws-sdk-go)
- etcd-io/etcd [![etcd](https://api.travis-ci.org/sourcegraph-codeintel-showcase/etcd.svg?branch=master)](https://travis-ci.org/github/sourcegraph-codeintel-showcase/etcd)
- expressjs/express [![express](https://api.travis-ci.org/sourcegraph-codeintel-showcase/express.svg?branch=master)](https://travis-ci.org/github/sourcegraph-codeintel-showcase/express)
- sindresorhus/got [![got](https://api.travis-ci.org/sourcegraph-codeintel-showcase/got.svg?branch=master)](https://travis-ci.org/github/sourcegraph-codeintel-showcase/got)
- gohugoio/hugo [![hugo](https://api.travis-ci.org/sourcegraph-codeintel-showcase/hugo.svg?branch=master)](https://travis-ci.org/github/sourcegraph-codeintel-showcase/hugo)
- moment/moment [![moment](https://api.travis-ci.org/sourcegraph-codeintel-showcase/moment.svg?branch=develop)](https://travis-ci.org/github/sourcegraph-codeintel-showcase/moment)
- Microsoft/TypeScript [![TypeScript](https://api.travis-ci.org/sourcegraph-codeintel-showcase/TypeScript.svg?branch=master)](https://travis-ci.org/github/sourcegraph-codeintel-showcase/TypeScript)

### Circle CI

- angular/angular [![angular](https://circleci.com/gh/sourcegraph-codeintel-showcase/angular.svg?style=svg)](https://circleci.com/gh/sourcegraph-codeintel-showcase/angular/tree/master)
- grafana/grafana [![grafana](https://circleci.com/gh/sourcegraph-codeintel-showcase/grafana.svg?style=svg)](https://circleci.com/gh/sourcegraph-codeintel-showcase/grafana/tree/master)
- helm/helm [![helm](https://circleci.com/gh/sourcegraph-codeintel-showcase/helm.svg?style=svg)](https://circleci.com/gh/sourcegraph-codeintel-showcase/helm/tree/master)
- facebook/jest [![jest](https://circleci.com/gh/sourcegraph-codeintel-showcase/jest.svg?style=svg)](https://circleci.com/gh/sourcegraph-codeintel-showcase/jest/tree/master)
- prometheus/prometheus [![prometheus](https://circleci.com/gh/sourcegraph-codeintel-showcase/prometheus.svg?style=svg)](https://circleci.com/gh/sourcegraph-codeintel-showcase/prometheus/tree/master)
- facebook/react [![react](https://circleci.com/gh/sourcegraph-codeintel-showcase/react.svg?style=svg)](https://circleci.com/gh/sourcegraph-codeintel-showcase/react/tree/master)
- ReactiveX/rxjs [![rxjs](https://circleci.com/gh/sourcegraph-codeintel-showcase/rxjs.svg?style=svg)](https://circleci.com/gh/sourcegraph-codeintel-showcase/rxjs/tree/master)

## Adding a fork

To add a fork to the upstreamer pipeline, perform the following steps:

1. Generate a new RSA key pair as follows:

```
ssh-keygen -t rsa -b 1096 -C "you@sourcegraph.com"
```

2. Add the public key as a deploy key in the forked repository's settings. Ensure that the `Allow write access` option is checked.
3. Add the secret key to the BuildKite agent's [SSH directory](https://github.com/sourcegraph/infrastructure/blob/48a0442c2878910f4ab8769e450b5d227fa2745b/kubernetes/ci/buildkite/buildkite-agent/buildkite-ssh.Secret.yaml#L7).
4. Update to BuildKite according to the [instructions](https://github.com/sourcegraph/infrastructure/blob/master/kubernetes/ci/README.md).
5. Add the fork's name and original owner to the map in [gen-pipeline.go](./.buildkite/gen-pipeline.go) and push to master to trigger a new build.
6. Add build badges to the list above.
