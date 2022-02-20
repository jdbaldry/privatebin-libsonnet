{
  apiVersion: 'tanka.dev/v1alpha1',
  kind: 'Environment',
  metadata: { name: '.' },
  data: (import './main.libsonnet').new(),
}
