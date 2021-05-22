local k = import 'ksonnet-util/kausal.libsonnet';

{
  new(
    name='privatebin',
    image='privatebin/nginx-fpm-alpine:1.3.4',
  ):: {

    local container = k.core.v1.container,
    container::
      container.new('privatebin', image)
      + container.withPorts([
        k.core.v1.containerPort.newNamed(name='http', containerPort=8080),
      ])
      + k.util.resourcesRequests('50m', '100Mi')
      + k.util.resourcesLimits('150m', '300Mi')
      + container.livenessProbe.httpGet.withPath('/')
      + container.livenessProbe.httpGet.withPort('http')
      + container.readinessProbe.httpGet.withPath('/')
      + container.readinessProbe.httpGet.withPort('http')
    ,

    local deployment = k.apps.v1.deployment,
    deployment: deployment.new(name, 1, [self.container]),

    service: k.util.serviceFor(self.deployment),
  },
}
