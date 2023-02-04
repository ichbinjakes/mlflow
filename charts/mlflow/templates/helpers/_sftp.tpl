{{/* SSH Identity file secret volume */}}
{{- define "mlflow.sftpIdentityVolume" -}}
{{- if .Values.artifacts.sftp.existingSecret -}}
- name: sftp-identity-file
  secret:
    secretName: {{ .Values.artifacts.sftp.existingSecret }}
    optional: false
{{- end -}}
{{- end -}}

{{/* SSH Identity file volume mount */}}
{{- define "mlflow.sftpIdentityVolumeMount" -}}
{{- if .Values.artifacts.s3.caBundleSecret -}}
- name: sftp-identity-file
  mountPath: "/ca-bundle.pem"
  readOnly: true
{{- end -}}
{{- end -}}

{{/* SSH config config map volume */}}
{{- define "mlflow.sftpSshConfigVolume" -}}
{{- if .Values.artifacts.s3.caBundleSecret -}}
- name: ssh-config
  secret:
    secretName: .Values.artifacts.s3.caBundleSecret
    optional: false
{{- end -}}
{{- end -}}

{{/* SSH config volume mount */}}
{{- define "mlflow.sftpSshConfigVolumeMount" -}}
{{- if .Values.artifacts.s3.caBundleSecret -}}
- name: ssh-config
  mountPath: "/ca-bundle.pem"
  readOnly: true
{{- end -}}
{{- end -}}