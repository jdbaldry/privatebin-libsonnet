local k = import 'ksonnet-util/kausal.libsonnet';
local deployment = k.apps.v1.deployment;
local container = k.core.v1.container;

{
  image:: 'privatebin/nginx-fpm-alpine:1.3.4',

  container::
    container.new('privatebin', $.image)
    + container.withPorts([
      k.core.v1.containerPort.newNamed(name='http', containerPort=8080),
    ])
    + k.utils.resourcesRequests('50m', '100Mi')
    + k.utils.resourcesLimits('150m', '300Mi')
    + container.livenessProbe.httpGet.withPath('/')
    + container.livenessProbe.httpGet.withPort('http')
    + container.readinessProbe.httpGet.withPath('/')
    + container.livenessProbe.httpGet.withPort('http')
  ,

  deployment: deployment.new('privatebin', 1, [$.container]),
  service: k.utils.serviceFor($.deployment),
}
