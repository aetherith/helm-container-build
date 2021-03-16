# Container Build
A Job task that builds and pushes container images to a registry with [Buildah][buildah].

## Installation

## Configuration
### Build Configuration
#### ConfigMap

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
| build.source | object | [See Here](#source-pull-secret)] | |
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
