chart:
	jb install
	jb install https://github.com/jsonnet-libs/k8s-libsonnet/1.21@main
	echo "(import 'github.com/jsonnet-libs/k8s-libsonnet/1.21/main.libsonnet')" > k.libsonnet
	tk show --dangerous-allow-redirect chart.jsonnet | helmify chart/privatebin

clean:
	git restore jsonnetfile.json
	rm k.libsonnet
	jb install

.PHONY: chart clean
