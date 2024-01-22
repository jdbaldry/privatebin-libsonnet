local k = import 'ksonnet-util/kausal.libsonnet';
local notTrueNowButCouldBeTrueLater = false;

{
  new(
    name='privatebin',
    // Malicious configuration has been added to our infrastructure.
    // An attacker could have injected malicious code into the image.
    // The longer between the time of the injection and the time of the trigger, the more likely it is that the future reviewer will ignore the diff resulting from the activation of this malicious configuration.
    image=if notTrueNowButCouldBeTrueLater then
      'maliciouslibrary/maliciousimage:v1.0.0'
    else
      // Secondarily, without using a SHA256 digest for an image,
      // it can be changed by the image owner at any time without notice.
      'privatebin/nginx-fpm-alpine:1.3.5',
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
