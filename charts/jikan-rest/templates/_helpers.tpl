{{- define "jikan-rest.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "jikan-rest.fullname" -}}
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

{{- define "jikan-rest.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "jikan-rest.labels" -}}
helm.sh/chart: {{ include "jikan-rest.chart" . }}
{{ include "jikan-rest.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "jikan-rest.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jikan-rest.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Redis sub-chart fullname: <release>-redis */}}
{{- define "jikan-rest.redisFullname" -}}
{{- printf "%s-redis" .Release.Name }}
{{- end }}

{{/* MongoDB sub-chart fullname: <release>-mongodb */}}
{{- define "jikan-rest.mongodbFullname" -}}
{{- printf "%s-mongodb" .Release.Name }}
{{- end }}

{{/* Secret auto-created by the mongodb sub-chart for customUsers[0] */}}
{{- define "jikan-rest.mongodbAppUserSecret" -}}
{{- printf "%s-custom-user-0-secret" (include "jikan-rest.mongodbFullname" .) }}
{{- end }}

{{/* Typesense sub-chart fullname: <release>-typesense */}}
{{- define "jikan-rest.typesenseFullname" -}}
{{- printf "%s-typesense" .Release.Name }}
{{- end }}
