# Upstreamer

This repository configures a [BuildKite pipeline](https://buildkite.com/sourcegraph/sourcegraph-codeintel-showcase-upstreamer/builds?branch=master) that periodically fetches and merges upstream changes to the forks in the [Sourcegraph codeintel showcase organization](https://github.com/sourcegraph-codeintel-showcase).

Each fork contains a series of commits on top of the upstream master that changes the continuous integration configuration to upload LSIF indexes to [sourcegraph.com](https://sourcegraph.com). All upstream changes _under_ are kept up to date.

### Adding a fork

To add a fork to the upstreamer pipeline, perform the following steps:

1. Generate a new RSA key pair as follows:

```
ssh-keygen -t rsa -b 1096 -C "you@sourcegraph.com"
```

2. Add the public key as a deploy key in the forked repository's settings. Ensure that the `Allow write access` option is checked.
3. Add the secret key to the BuildKite agent's [SSH directory](https://github.com/sourcegraph/infrastructure/blob/48a0442c2878910f4ab8769e450b5d227fa2745b/kubernetes/ci/buildkite/buildkite-agent/buildkite-ssh.Secret.yaml#L7).
4. Update to BuildKite according to the [instructions](https://github.com/sourcegraph/infrastructure/blob/master/kubernetes/ci/README.md).
5. Add the fork's name and original owner to the map in [gen-pipeline.go](./.buildkite/gen-pipeline.go) and push to master to trigger a new build.
