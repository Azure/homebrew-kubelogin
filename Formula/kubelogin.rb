# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class Kubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.0.8"
  license "MIT"

  if OS.mac?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "389987e03d7ea7fb2dd2ad4aab19a83e7dfa063943594a04434741e6d18339ac"
  end
  if OS.linux?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "fffa36a3ad9310e7548f52e6b55fd3928362f43aa4e0a45dd5807ce991483080"
  end

  def install
    if OS.mac?
      bin.install "darwin_amd64/kubelogin"
    end
    if OS.linux?
      bin.install "linux_amd64/kubelogin"
    end
  end

  test do
    system bin/name, "version"
  end
end
