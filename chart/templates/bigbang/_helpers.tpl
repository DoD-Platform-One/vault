{{/*
Create the selector labels for the Vault deployment.
*/}}
{{- define "vault.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vault.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "vault.labels" -}}
app.kubernetes.io/name: {{ include "vault.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "minio.labels" -}}
app: minio
{{- end }}
