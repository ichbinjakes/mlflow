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
{{- else -}}
- secretRef:
    name: mlflow-artifacts-credentials
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
{{/* AZURE - value from secret */}}
{{- else if .Values.artifacts.azure.defaultArtifactRoot -}}
- name: DEFAULT_ARTIFACT_ROOT
  value: {{ .Values.artifacts.azure.defaultArtifactRoot }} 
{{- else -}}
{{  fail "Could not determine default artifact root from supplied values" }}
{{- end -}}
{{- end -}}


{{/* Get the image tag */}}
{{- define "mlflow.imageTag" -}}
{{- if .Values.image.tag -}}
{{ .Values.image.tag }}
{{- else -}}
{{ .Chart.AppVersion }}
{{- end -}}
{{- end -}}
