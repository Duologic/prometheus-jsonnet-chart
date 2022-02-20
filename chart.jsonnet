local prometheus = import 'github.com/grafana/jsonnet-libs/prometheus/prometheus.libsonnet';

{
  apiVersion: 'tanka.dev/v1alpha1',
  kind: 'Environment',
  metadata: { name: '.' },
  data: prometheus
        //+ prometheus.withMixinsConfigmaps(prometheus.mixins)
        + prometheus.withMixinsLegacyConfigmaps(
          prometheus.mixins {
            base+: {
              prometheusRules+: {
                groups+: [{
                  name: 'example',
                  rules: [{
                    record: 'example:recording',
                    expr: 'up',
                  }],
                }],
              },
            },
          }
        )
        + {
          _config+:: {
            namespace: '{{ .Release.Namespace }}',
          },
        },
}
