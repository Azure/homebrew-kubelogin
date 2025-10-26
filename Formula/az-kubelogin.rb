# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class AzKubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.2.12"
  license "MIT"

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "2a8209775defce130e5710ca85132c948df8d9590cd305915692eacc0e4997fd"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-arm64.zip"
    sha256 "ea5e9885082be65952b80e6ddcb7a2fde2a629be3589dbded943320957d0b07b"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "e029ab06fdaf2a6b17132e9625d5b5412d7cf945e95b1e8b5850695070657384"
  else
    odie "Unexpected platform!"
  end
  
  def install
    case
    when OS.mac? && Hardware::CPU.intel?
      bin.install "darwin_amd64/kubelogin" => "az-kubelogin"
    when OS.mac? && Hardware::CPU.arm?
      bin.install "darwin_arm64/kubelogin" => "az-kubelogin"
    when OS.linux? && Hardware::CPU.intel?
      bin.install "linux_amd64/kubelogin" => "az-kubelogin"
    else
      odie "Unexpected platform!"
    end
  end

  test do
    system "#{bin}/az-kubelogin --version"
  end
end
