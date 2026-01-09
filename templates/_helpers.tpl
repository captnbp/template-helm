{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper %%COMPONENT_NAME%% image name
*/}}
{{- define "%%COMPONENT_NAME%%.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "%%COMPONENT_NAME%%.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" .Values.image "global" .Values.global) -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "%%COMPONENT_NAME%%.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return true if cert-manager required annotations for TLS signed certificates are set in the Ingress annotations
Ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
*/}}
{{- define "%%COMPONENT_NAME%%.ingress.certManagerRequest" -}}
{{ if or (hasKey . "cert-manager.io/cluster-issuer") (hasKey . "cert-manager.io/issuer") }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a TLS credentials secret object should be created
*/}}
{{- define "%%COMPONENT_NAME%%.createTlsSecret" -}}
{{- if and (not .Values.tls.existingSecret) .Values.tls.enabled }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the TLS secret name
*/}}
{{- define "%%COMPONENT_NAME%%.issuerName" -}}
{{- $issuerName := .Values.tls.issuerRef.existingIssuerName -}}
{{- if $issuerName -}}
    {{- printf "%s" (tpl $issuerName $) -}}
{{- else -}}
    {{- printf "%s-http" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}


{{/*
Return the CNP cluster fullname
*/}}
{{- define "%%COMPONENT_NAME%%.postgresql.fullname" -}}
{{- if .Values.postgresql.name -}}
{{- .Values.postgresql.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-postgresql" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Return the CNP cluster service name (read-write)
*/}}
{{- define "%%COMPONENT_NAME%%.postgresql.serviceName" -}}
{{- printf "%s-rw" (include "%%COMPONENT_NAME%%.postgresql.fullname" .) -}}
{{- end -}}

{{/*
Return the CNP secret name
*/}}
{{- define "%%COMPONENT_NAME%%.postgresql.secretName" -}}
{{- if .Values.postgresql.database.existingSecret -}}
{{- .Values.postgresql.database.existingSecret -}}
{{- else -}}
{{- printf "%s-app" (include "%%COMPONENT_NAME%%.postgresql.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the CNP database password
*/}}
{{- define "%%COMPONENT_NAME%%.postgresql.password" -}}
{{- $secretData := (lookup "v1" "Secret" $.Release.Namespace (include "%%COMPONENT_NAME%%.postgresql.secretName" .)).data }}
{{- if and $secretData (hasKey $secretData "password") }}
{{- index $secretData "password" | b64dec }}
{{- else }}
{{- randAlphaNum 32 }}
{{- end }}
{{- end -}}

{{/*
Get the database host
*/}}
{{- define "%%COMPONENT_NAME%%.database.host" -}}
{{- if .Values.postgresql.enabled -}}
{{- $releaseNamespace := .Release.Namespace }}
{{- $clusterDomain := .Values.clusterDomain }}
{{- $serviceName := include "%%COMPONENT_NAME%%.postgresql.serviceName" . }}
{{- printf "%s.%s.svc.%s" $serviceName $releaseNamespace $clusterDomain -}}
{{- else -}}
{{- .Values.externalDatabase.host -}}
{{- end -}}
{{- end -}}

{{/*
Get the database port
*/}}
{{- define "%%COMPONENT_NAME%%.database.port" -}}
{{- if .Values.postgresql.enabled -}}
5432
{{- else -}}
{{- .Values.externalDatabase.port -}}
{{- end -}}
{{- end -}}

{{/*
Get the database name
*/}}
{{- define "%%COMPONENT_NAME%%.database.name" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.database.name -}}
{{- else -}}
{{- .Values.externalDatabase.database -}}
{{- end -}}
{{- end -}}

{{/*
Get the database username
*/}}
{{- define "%%COMPONENT_NAME%%.database.username" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.database.username -}}
{{- else -}}
{{- .Values.externalDatabase.username -}}
{{- end -}}
{{- end -}}

{{/*
Get the Postgresql credentials secret.
*/}}
{{- define "%%COMPONENT_NAME%%.databaseSecretName" -}}
{{- if .Values.postgresql.enabled -}}
{{- include "%%COMPONENT_NAME%%.postgresql.secretName" . -}}
{{- else -}}
{{- default (printf "%s-externaldb" .Release.Name) (tpl .Values.externalDatabase.existingSecret $) -}}
{{- end -}}
{{- end -}}

{{/*
Add environment variables to configure database values
*/}}
{{- define "%%COMPONENT_NAME%%.databaseSecretKey" -}}
{{- if .Values.postgresql.enabled -}}
    {{- print "password" -}}
{{- else -}}
    {{- if .Values.externalDatabase.existingSecret -}}
        {{- if .Values.externalDatabase.existingSecretPasswordKey -}}
            {{- printf "%s" .Values.externalDatabase.existingSecretPasswordKey -}}
        {{- else -}}
            {{- print "password" -}}
        {{- end -}}
    {{- else -}}
        {{- print "password" -}}
    {{- end -}}
{{- end -}}
{{- end -}}
