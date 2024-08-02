{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "common_redis.names.name" -}}
{{- default .Values.fullnameOverride -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common_redis.names.chart" -}}
{{- printf "%s" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common_redis.names.fullname" -}}
{{- default .Values.fullnameOverride -}}
{{- end -}}

{{/*
Create a default fully qualified dependency name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
Usage:
{{ include "common_redis.names.dependency.fullname" (dict "chartName" "dependency-chart-name" "chartValues" .Values.dependency-chart "context" $) }}
*/}}
{{- define "common_redis.names.dependency.fullname" -}}
{{- if .chart.Values.fullnameOverride -}}
{{- .chart.Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Values.fullnameOverride -}}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "common_redis.names.namespace" -}}
{{- default .Values.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fully qualified app name adding the installation's namespace.
*/}}
	{{- define "redis.common_redis.names.fullname.namespace" -}}
{{- printf "%s-%s" (include "common_redis.names.fullname" .) (include "common_redis.names.namespace" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
