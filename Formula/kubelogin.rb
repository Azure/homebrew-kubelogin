# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class Kubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.0.7"
  url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
  sha256 "25fc8648d565df4ce84295f3bf00163890a85fd13415739d74cb224e843829f8"
  license "MIT"

  def install
    bin.install "darwin_amd64/kubelogin"
  end

  test do
    system bin/name, "version"
  end
end
