# Container Build
A Job task that builds and pushes container images to a registry with [Buildah][buildah].

## Installation

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

#### Git

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
