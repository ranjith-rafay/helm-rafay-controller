{{/* vim: set filetype=mustache: */}}
{{/*
Print instructions to get a secret value.
Usage:
{{ include "common_redis.utils.secret.getvalue" (dict "secret" "secret-name" "field" "secret-value-field" "context" $) }}
*/}}
{{- define "common_redis.utils.secret.getvalue" -}}
{{- $varname := include "common_redis.utils.fieldToEnvVar" . -}}
export {{ $varname }}=$(kubectl get secret --namespace {{ include "common_redis.names.namespace" .context | quote }} {{ .secret }} -o jsonpath="{.data.{{ .field }}}" | base64 -d)
{{- end -}}

{{/*
Build env var name given a field
Usage:
{{ include "common_redis.utils.fieldToEnvVar" dict "field" "my-password" }}
*/}}
{{- define "common_redis.utils.fieldToEnvVar" -}}
  {{- $fieldNameSplit := splitList "-" .field -}}
  {{- $upperCaseFieldNameSplit := list -}}

  {{- range $fieldNameSplit -}}
    {{- $upperCaseFieldNameSplit = append $upperCaseFieldNameSplit ( upper . ) -}}
  {{- end -}}

  {{ join "_" $upperCaseFieldNameSplit }}
{{- end -}}

{{/*
Gets a value from .Values given
Usage:
{{ include "common_redis.utils.getValueFromKey" (dict "key" "path.to.key" "context" $) }}
*/}}
{{- define "common_redis.utils.getValueFromKey" -}}
{{- $splitKey := splitList "." .key -}}
{{- $value := "" -}}
{{- $latestObj := $.context.Values -}}
{{- range $splitKey -}}
  {{- if not $latestObj -}}
    {{- printf "please review the entire path of '%s' exists in values" $.key | fail -}}
  {{- end -}}
  {{- $value = ( index $latestObj . ) -}}
  {{- $latestObj = $value -}}
{{- end -}}
{{- printf "%v" (default "" $value) -}} 
{{- end -}}

{{/*
Returns first .Values key with a defined value or first of the list if all non-defined
Usage:
{{ include "common_redis.utils.getKeyFromList" (dict "keys" (list "path.to.key1" "path.to.key2") "context" $) }}
*/}}
{{- define "common_redis.utils.getKeyFromList" -}}
{{- $key := first .keys -}}
{{- $reverseKeys := reverse .keys }}
{{- range $reverseKeys }}
  {{- $value := include "common_redis.utils.getValueFromKey" (dict "key" . "context" $.context ) }}
  {{- if $value -}}
    {{- $key = . }}
  {{- end -}}
{{- end -}}
{{- printf "%s" $key -}} 
{{- end -}}
