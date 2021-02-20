# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class Kubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.0.8"
  license "MIT"

  if OS.mac?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "5835457f09189fedb1a96524f01215c93cf76b818a670bb5854ee8fa2ba1ea22"
  end
  if OS.linux?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "fcf02d449d04e730d4fb3aa7b327724c75912594e1b766688bc35c3d8007688a"
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
