# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class Kubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.0.33"
  license "MIT"

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "f9994a35c89729cd6a21f10a7fef7bf097b67d6de0b946239f9cc4d09fb47dff"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-arm64.zip"
    sha256 "88940297a9991cbb8c79e0f8f03a73c1ca8165bc82ff42e65853ed3a6b7a77be"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "58ea5fc24bdd6c7faf4f4c9ef298244fc70e82076e720425a9d043dc57e94599"
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
