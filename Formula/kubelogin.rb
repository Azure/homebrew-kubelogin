# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class Kubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.0.7"
  license "MIT"

  if OS.mac?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "25fc8648d565df4ce84295f3bf00163890a85fd13415739d74cb224e843829f8"
  end
  if OS.linux?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "c87c8d89d96002acde455f30e5c3f2356505643184bf5b82a6a42d05dba4808b"
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
