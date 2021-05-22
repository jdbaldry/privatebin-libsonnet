# PrivateBin jsonnet library

Jsonnet library for https://privatebin.info/

## Usage

Install it with jsonnet-bundler:

```console
jb install https://github.com/Duologic/privatebin-libsonnet`
```

Import into your jsonnet:

```jsonnet
local privatebin = import 'github.com/Duologic/privatebin-libsonnet/privatebin.libsonnet';

{
  privatebin: privatebin { image:: 'privatebin/nginx-fpm-alpine:1.3.4' },
}
```
