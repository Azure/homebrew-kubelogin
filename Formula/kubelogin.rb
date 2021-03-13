# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class Kubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.0.9"
  license "MIT"

  if OS.mac?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "d7001eaa9679d2dacaab637da5216ed479d1febe13bbdb663d388c67cde9d206"
  end
  if OS.linux?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "f342bac76b47f2d0db56efa59037eb39fce7626ffa24c7470e184828ac51222b"
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
