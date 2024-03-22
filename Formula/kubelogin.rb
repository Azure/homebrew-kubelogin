# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class Kubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.1.1"
  license "MIT"

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "b805ba4ff24e644fc841394901a06b2f4f62d6332e5ea012225f0b09c7daf45b"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-arm64.zip"
    sha256 "4746419ce98ac517d8eadc843d168c509673799e2ae5272e158308b0ca7e70f5"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "51938ead06738bce6bb8fa4418fe043a5106a7d8bad037a65b57170c4f3fba0e"
  else
    odie "Unexpected platform!"
  end

  def install
    case
    when OS.mac? && Hardware::CPU.intel?
      bin.install "darwin_amd64/kubelogin"
    when OS.mac? && Hardware::CPU.arm?
      bin.install "darwin_arm64/kubelogin"
    when OS.linux? && Hardware::CPU.intel?
      bin.install "linux_amd64/kubelogin"
    else
      odie "Unexpected platform!"
    end
  end

  test do
    system bin/name, "version"
  end
end
