# Container Build
A Job task that builds and pushes container images to a registry with [Buildah][buildah].

## Installation

```bash
helm install build container-build --values values.yml
```

## Configuration
### Build Configuration
Buildah is capable of grabbing its Containerfile configuration from a file
available on the local filesystem as well as HTTP/HTTPS URL and Git repository.
This chart is configured to allow any of these configuration methods through
specific configuration sets.

#### ConfigMap
If you want to specify your Dockerfile within your Kubernetes configuration you
can achieve this through the `configMap` build option.

```yaml
build:
  configMap:
    enabled: true
    dockerfileData: |
      FROM docker.io/library/centos:8
      RUN dnf -y install ansible
```

If you would prefer to manually manage your build configuration you may also
create the `ConfigMap` and provide it's name to the chart through `build.configMap.name`
while setting `build.configMap.create` to `false`.

#### URL
The chart can also be used to build a Dockerfile available from a HTTP or HTTPS
URI by enabling the appropriate mode and providing the path.

```yaml
build:
  url:
    enabled: true
    uri: http://example.com/Dockerfile
```

Additionally, this mode supports using HTTP Basic Authentication to grab resources
that require a username and password. If you do not wish to use the chart created
secret, set `build.url.authSecret.create` to `false` and provide the name of an
appropriately formatted secret in `build.url.authSecret.name`.

```yaml
build:
  url:
    enabled: true
    uri: https://example.com/Dockerfile
    authSecret:
      enabled: true
      username: <USERNAME>
      password: <PASSWORD>
```

#### Git
The last mode that the chart can be used for is building from a Git repository.
This requires that the Dockerfile exist at the root of the repository and be
named specifically `Dockerfile`.

```yaml
build:
  git:
    enabled: true
    uri: git://example.com/repository
```

This mode also supports authentication, though at present only SSH keys have
been attempted in the chart. To use them, add the following to your values file.

```yaml
build:
  git:
    enabled: true
    uri: git://example.com/repository
    authSecret:
      enabled:
      sshPrivateKey: |
        -----BEGIN OPENSSH PRIVATE KEY-----
        ...
```

Also like the URL mode you can provide a pre-created SSH key secret by disabling
secret creation and setting the `authSecret` name appropriately.

### Container Image Registries
#### Source Pull Secret

#### Destination Push Secret

## Chart Values
| Key | Type | Default | Description |
| --- | ---- | ------- | ----------- |
| image.repository | string | "quay.io/buildah/stable" | |
| image.tag | string | "{{ .Chart.AppVersion }}"
| image.pullPolicy | string | "IfNotPresent" | |
| build.configMap | object | [See Here](#configmap) | |
| build.url | object | [See Here](#url) | |
| build.git | object | [See Here](#git) | |
| build.source | object | [See Here](#source-pull-secret) | |
| build.destination | object | [See Here](#destination-push-secret) | |
| imagePullSecrets | list | [] | |
| nameOverride | string | "" | |
| fullnameOverride | string | "" | |
| serviceAccount.create | bool | true | |
| serviceAccount.annotations | object | {} | |
| serviceAccount.name | string | "" | |
| podRestartPolicy | string | Never | Should the Job pods be restarted on failure? |
| podAnnotations | object | {} | |
| podSecurityContext | object | {} | |
| securityContext | object | {} | |
| resources | object | {} | |
| nodeSelector | object | {} | |
| tolerations | list | [] | |
| affinity | object | {} | |

[buildah]: https://buildah.io
