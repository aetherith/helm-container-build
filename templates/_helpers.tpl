{{/*
Expand the name of the chart.
*/}}
{{- define "container-build.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "container-build.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create authSecret name for URL and Git config sources.
*/}}
{{- define "container-build.configAuthSecretName" -}}
{{- printf "%s-config-auth" (include "container-build.fullname" .) | trunc 51 | trimSuffix "-" }}
{{- end }}

{{- define "container-build.sourceAuthSecretName" -}}
{{- printf "%s-source-auth" (include "container-build.fullname" .) | trunc 51 | trimSuffix "-" }}
{{- end }}

{{- define "container-build.sourceAuthSecretData" -}}
{{- printf "%s:%s" .username .password | b64enc }}
{{- end }}

{{- define "container-build.destinationAuthSecretName" -}}
{{- printf "%s-dest-auth" (include "container-build.fullname" .) | trunc 53 | trimSuffix "-" }}
{{- end }}

{{- define "container-build.destinationAuthSecretData" -}}
{{- printf "%s:%s" .authSecret.username .authSecret.password | b64enc }}
{{- end }}

{{/*
Create a HTTP basic authentication enabled URL.
*/}}
{{- define "container-build.basicAuthConfigUrl" -}}
{{- with .Values.build.url }}
{{- regexReplaceAll "^(.*)://(.*)$" .uri "${1}://$(USERNAME):$(PASSWORD)@${2}" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "container-build.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "container-build.labels" -}}
helm.sh/chart: {{ include "container-build.chart" . }}
{{ include "container-build.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "container-build.selectorLabels" -}}
app.kubernetes.io/name: {{ include "container-build.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "container-build.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "container-build.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
