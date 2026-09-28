# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class AzKubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.2.20"
  license "MIT"

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "533f2f159d40b81d890efbddb902ab49a04431669c89b1027dc0b0f0eaaf6729"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-arm64.zip"
    sha256 "1583a65ed6833145a9427f7920ae8cfb7b86244b1b3e8c6b4a0f016101d1634d"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "2e92450a929dd2aec4da818b40dd4fda97aaeae2d6cd9c1074cc1371210f4ab9"
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
