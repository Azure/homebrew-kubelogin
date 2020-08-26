# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class Kubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.0.5"
  url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
  sha256 "985d614689222c62c1cc635f23eb2bc0b66b8b97b8f13a7bf4594e42cc22edcf"
  license "MIT"

  def install
    bin.install "bin/darwin_amd64/kubelogin"
  end

  test do
    system bin/name, "version"
  end
end
