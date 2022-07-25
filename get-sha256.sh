#!/bin/bash

set -e

[[ -z ${KUBELOGIN_VERSION} ]] && echo environment variable 'KUBELOGIN_VERSION' is required && exit 1

ARCHIVES=(kubelogin-darwin-amd64.zip kubelogin-darwin-arm64.zip kubelogin-linux-amd64.zip)

for zip in ${ARCHIVES[@]}; do
  curl -sL https://github.com/Azure/kubelogin/releases/download/v${KUBELOGIN_VERSION}/${zip}.sha256
done
