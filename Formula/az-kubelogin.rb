# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.
class AzKubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.0.17"
  license "MIT"

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "2cab67571218c300687505d507a6a7a7fb93a990b23611d3918629015fbc088b"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-arm64.zip"
    sha256 "a349356204bd805b4afa4560c766c419ce7ae8e3b20165437b35ab9844ec76a2"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "c0bcf1cb969c1b8cc5fd43b032a5d1cee14bf65b6da6f65d671c64e5a3844a80"
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
