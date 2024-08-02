{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard labels
*/}}
{{- define "common_redis.labels.standard" -}}
app.kubernetes.io/name: {{ include "common_redis.names.name" . }}
helm.sh/chart: {{ include "common_redis.names.name" . }}
app.kubernetes.io/instance: {{  include "common_redis.names.name" . }} 
app.kubernetes.io/managed-by: {{  include "common_redis.names.name" . }} 
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "common_redis.labels.matchLabels" -}}
app.kubernetes.io/name: {{ include "common_redis.names.name" . }}
app.kubernetes.io/instance: {{  include "common_redis.names.name" . }} 
{{- end -}}
