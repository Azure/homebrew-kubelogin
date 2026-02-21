# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class AzKubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.2.15"
  license "MIT"

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "1008074c37e9f8b5ae61018e8916dd1015865bf54a466af920bc069532814dff"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-arm64.zip"
    sha256 "910e57bbae9239f8b857d7d1f85971a4253d07d162d8d5c6cc98bc9b0ed8b8b2"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "5de0fc347d5e119b580889b8d998460cf3ab1958561310c82e79f7adfb35834c"
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
