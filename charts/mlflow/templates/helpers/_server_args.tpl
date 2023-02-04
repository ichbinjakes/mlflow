{{/* mlflow enable tracking features */}}
{{- define "mlflow.enableTracking" -}}
{{- if not .Values.trackingServer.enabled -}}
--artifacts-only
{{- end -}}
{{- end -}}

{{/* mlflow server port */}}
{{- define "mlflow.serverPort" -}}
{{- if .Values.trackingServer.port -}}
--port={{ .Values.trackingServer.port }}
{{- end -}}
{{- end -}}

{{/* mlflow server worker */}}
{{- define "mlflow.serverWorkers" -}}
{{- if .Values.trackingServer.workers -}}
--workers={{ .Values.trackingServer.worker }}
{{- end -}}
{{- end -}}

{{/* mlflow server metrics */}}
{{- define "mlflow.serverMetrics" -}}
{{- if .Values.trackingServer.metrics -}}
--expose-prometheus={{ .Values.trackingServer.metrics }}
{{- end -}}
{{- end -}}

{{/* mlflow server proxy artifacts */}}
{{- define "mlflow.proxyArtifacts" -}}
{{- if .Values.artifacts.serve -}}
--serve-artifacts
{{- else -}}
--no-serve-artifacts
{{- end -}}
{{- end -}}
