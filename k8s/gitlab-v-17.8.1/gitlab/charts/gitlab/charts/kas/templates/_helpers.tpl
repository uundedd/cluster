{{/*
Returns the secret name for the Secret containing the TLS certificate and key.
Uses `ingress.tls.secretName` first and falls back to `global.ingress.tls.secretName`
if there is a shared tls secret for all ingresses.
*/}}
{{- define "kas.tlsSecret" -}}
{{- $defaultName := (dict "secretName" "") -}}
{{- if .Values.global.ingress.configureCertmanager -}}
{{- $_ := set $defaultName "secretName" (printf "%s-kas-tls" .Release.Name) -}}
{{- else -}}
{{- $_ := set $defaultName "secretName" (include "gitlab.wildcard-self-signed-cert-name" .) -}}
{{- end -}}
{{- pluck "secretName" .Values.ingress.tls .Values.global.ingress.tls $defaultName | first -}}
{{- end -}}

{{/*
Build Redis config for KAS
*/}}
{{- define "kas.redis" -}}
{{- if .Values.redis.enabled -}}
{{- if .Values.global.redis.kas -}}
{{-   $_ := set $ "redisConfigName" "kas" -}}
{{- else if .Values.global.redis.sharedState -}}
{{-   $_ := set $ "redisConfigName" "sharedState" -}}
{{- end -}}
{{- include "gitlab.redis.selectedMergedConfig" . -}}
{{- if .redisMergedConfig.user }}
username: {{ .redisMergedConfig.user }}
{{- end -}}
{{- if .redisMergedConfig.password.enabled }}
password_file: /etc/kas/redis/{{ printf "%s-password" (default "redis" .redisConfigName) }}
{{- end }}
database_index: {{ .redisMergedConfig.database }} 
{{- if not .redisMergedConfig.sentinels }}
server:
  address: {{ template "gitlab.redis.host" . }}:{{ template "gitlab.redis.port" . }}
{{- else }}
sentinel:
  addresses:
  {{- range $i, $entry := .redisMergedConfig.sentinels }}
    - {{ quote (print (trim $entry.host) ":" ( default 26379 $entry.port | int ) ) -}}
  {{ end }}
  master_name: {{ template "gitlab.redis.host" . }}
{{- if .redisMergedConfig.sentinelAuth.enabled }}
  sentinel_password_file: "/etc/kas/redis-sentinel/redis-sentinel-password"
{{- end -}}
{{- end -}}
{{- if eq (.redisMergedConfig.scheme | default "") "rediss" }}
tls:
  enabled: true
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Labels to select Pods created by the KAS Deployment. Used for Service, PodMonitor, ServiceMonitor, etc.
*/}}
{{- define "kas.podSelectorLabels" -}}
app: {{ template "name" . }}
release: {{ .Release.Name }}
{{- end -}}
