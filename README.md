# PrivateBin Jsonnet lib

Simple jsonnet lib for installing PrivateBin as a deployment.

## Usage

Install it with jsonnet-bundler:

    jb install https://github.com/Duologic/privatebin-libsonnet`

Import into your jsonnet:

    local privatebin = import 'github.com/Duologic/privatebin-libsonnet/privatebin.libsonnet';

    {
        privatebin: privatebin { image:: 'privatebin/nginx-fpm-alpine:1.3.4' },
    }


