{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "dragonfly.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "supernode.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create unified labels for prometheus components
*/}}
{{- define "dragonfly.matchLabels" -}}
app: {{ template "dragonfly.name" . }}
release: {{ .Release.Name }}
{{- end -}}

{{- define "dragonfly.metaLabels" -}}
chart: {{ .Chart.Name }}-{{ .Chart.Version }}
heritage: {{ .Release.Service }}
{{- end -}}

{{- define "dfclient.labels" -}}
{{ include "dfclient.matchLabels" . }}
{{ include "dragonfly.metaLabels" . }}
{{- end -}}

{{- define "dfclient.matchLabels" -}}
component: {{ .Values.dfclient.name }}
{{ include "dragonfly.matchLabels" . }}
{{- end -}}

{{- define "supernode.labels" -}}
{{ include "supernode.matchLabels" . }}
{{ include "dragonfly.metaLabels" . }}
{{- end -}}

{{- define "supernode.matchLabels" -}}
component: {{ .Values.supernode.name }}
{{ include "dragonfly.matchLabels" . }}
{{- end -}}

{{/*
Create a fully qualified supernode name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "supernode.fullname" -}}
{{- if .Values.supernode.fullnameOverride -}}
{{- .Values.supernode.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.supernode.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.supernode.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified supernode name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "dfclient.fullname" -}}
{{- if .Values.dfclient.fullnameOverride -}}
{{- .Values.dfclient.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.dfclient.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.dfclient.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "supernode.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dfclient.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create the name of prometheus-operator service account to use */}}
{{- define "supernode.serviceAccountName" -}}
{{- if .Values.serviceAccounts.supernode.create -}}
    {{ default (include "supernode.fullname" .) .Values.serviceAccounts.supernode.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.supernode.name }}
{{- end -}}
{{- end -}}

{{/* Create the name of prometheus-operator service account to use */}}
{{- define "dfclient.serviceAccountName" -}}
{{- if .Values.serviceAccounts.dfclient.create -}}
    {{ default (include "dfclient.fullname" .) .Values.serviceAccounts.dfclient.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.dfclient.name }}
{{- end -}}
{{- end -}}