{{/* S3 CA bundle secret volume */}}
{{- define "mlflow.s3CaBundleVolume" -}}
{{- if .Values.artifacts.s3.caBundleSecret -}}
- name: s3-ca-bundle
  secret:
    secretName: {{ .Values.artifacts.s3.caBundleSecret }}
    optional: false
{{- end -}}
{{- end -}}

{{/* S3 CA bundle volume mount */}}
{{- define "mlflow.s3CaBundleVolumeMount" -}}
{{- if .Values.artifacts.s3.caBundleSecret -}}
- name: s3-ca-bundle
  mountPath: "/ca-bundle.pem"
  readOnly: true
{{- end -}}
{{- end -}}


{{/* S3 CA bundle path environment */}}
{{- define "mlflow.s3CaBundleEnv" -}}
{{- if .Values.artifacts.s3.caBundleSecret -}}
- name: AWS_CA_BUNDLE
  value: "/ca-bundle.pem"
{{- end -}}
{{- end -}}
