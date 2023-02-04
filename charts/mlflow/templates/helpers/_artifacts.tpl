{{/* Get the envFrom secret yaml for artifaces */}}
{{- define "mlflow.artifactEnvironmentFromSecret" -}}
{{/* S3 */}}
{{- if .Values.artifacts.s3.existingSecret -}}
- secretRef:
    name: {{ .Values.artifacts.s3.existingSecret }}
{{/* GCP */}}
{{- else if .Values.artifacts.gcp.existingSecret -}}
- secretRef:
    name: {{ .Values.artifacts.gcp.existingSecret }}
{{/* AZURE */}}
{{- else if .Values.artifacts.azure.existingSecret -}}
- secretRef:
    name: {{ .Values.artifacts.azure.existingSecret }}
{{/* FTP */}}
{{- else if .Values.artifacts.ftp.existingSecret -}}
- secretRef:
    name: {{ .Values.artifacts.ftp.existingSecret }}
{{/* SFTP */}}
{{- else if .Values.artifacts.sftp.existingSecret -}}
- secretRef:
    name: {{ .Values.artifacts.sftp.existingSecret }}
{{- else -}}
{{- fail "Could not determine artifact store configuration from supplied values" }}
{{- end -}}
{{- end -}}


{{/* Get the default artifact root */}}
{{- define "mlflow.defaultArtifactRootEnvironment" -}}
{{/* S3 */}}
{{- if .Values.artifacts.s3.defaultArtifactRoot -}}
- name: DEFAULT_ARTIFACT_ROOT
  value: {{ .Values.artifacts.s3.defaultArtifactRoot }} 
{{/* GCP */}}
{{- else if .Values.artifacts.gcp.defaultArtifactRoot -}}
- name: DEFAULT_ARTIFACT_ROOT
  value: {{ .Values.artifacts.gcp.defaultArtifactRoot }} 
{{/* SFTP */}}
{{- else if .Values.artifacts.sftp.defaultArtifactRoot -}}
- name: DEFAULT_ARTIFACT_ROOT
  value: {{ .Values.artifacts.sftp.defaultArtifactRoot }} 
{{- else -}}
{{/* AZURE - value from secret */}}
{{/* FTP - value from secret */}}
{{- end -}}
{{- end -}}


{{/* Get the image tag */}}
{{- define "mlflow.imageTag" -}}
{{- if .Values.image.tag -}}
{{ .Values.image.tag }}
{{- else if .Values.artifacts.s3.defaultArtifactRoot -}}
{{ .Chart.AppVersion }}-aws
{{- else if .Values.artifacts.gcp.defaultArtifactRoot -}}
{{ .Chart.AppVersion }}-gcp
{{- else if .Values.artifacts.azure.existingSecret -}}
{{ .Chart.AppVersion }}-azure
{{- else if .Values.artifacts.sftp.defaultArtifactRoot -}}
{{ .Chart.AppVersion }}-sftp
{{- else -}}
{{ .Chart.AppVersion }}
{{- end -}}
{{- end -}}