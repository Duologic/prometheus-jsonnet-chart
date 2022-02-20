chart:
	jb init || jb install
	jb install https://github.com/grafana/jsonnet-libs/prometheus
	jb install https://github.com/jsonnet-libs/k8s-libsonnet/1.21@main
	echo "(import 'github.com/jsonnet-libs/k8s-libsonnet/1.21/main.libsonnet')" > k.libsonnet
	tk show --dangerous-allow-redirect chart.jsonnet | helmify chart/prometheus

jbupdate:
	jb update

update: jbupdate chart

.PHONY: chart
