# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class AzKubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.1.3"
  license "MIT"

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "bf3e2397d43321c84219981566cc2e28d9e705e82e5374b9eac72dc83a0dab59"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-arm64.zip"
    sha256 "9d78824252f22f386eab83611fc45ecb9266451079eb1f7c21a4990ee96da6dc"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "3799622441a42ae612579e2d9480c731335033660baf95df375f7f407b76c80f"
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
