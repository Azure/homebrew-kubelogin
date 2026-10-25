# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class Kubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.2.22"
  license "MIT"

  case
  when OS.mac? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
    sha256 "6f4a17811e5d5815bb005daae5dabce3d016c2caac84a097f1db4263344f113e"
  when OS.mac? && Hardware::CPU.arm?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-arm64.zip"
    sha256 "b586d6409d578f2048053a6117ace47f0154f36c5beb6792c674679987a7efc8"
  when OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-amd64.zip"
    sha256 "716cbcb1880bca8f0e976b8917d06fcfe04de2c1e737eaaabbb26e2782330119"
  when OS.linux? && Hardware::CPU.arm?
    url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-linux-arm64.zip"
    sha256 "76eee872b4dda6a0378d57e019cfb394b6ed58e6aa209ea55d941065a73d37b4"
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
    when OS.linux? && Hardware::CPU.arm?
      bin.install "linux_arm64/kubelogin"
    else
      odie "Unexpected platform!"
    end
  end

  test do
    system bin/name, "version"
  end
end
