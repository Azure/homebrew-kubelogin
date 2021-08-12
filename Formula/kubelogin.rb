# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class Kubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.0.10"
  license "MIT"

  if OS.mac?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "e4d155139d36fc489d4366ca818c9c400bf35ebe347b0f1d5bb84864b406d420"
  end
  if OS.linux?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "2098de5b617fcfc1653c435488a2fc4cd32bdd2450fee17cdf5b1b3c08f6889b"
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
