# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

class Kubelogin < Formula
  desc "A Kubernetes credential (exec) plugin implementing azure authentication"
  homepage "https://github.com/Azure/kubelogin"
  version "0.0.6"
  url "https://github.com/Azure/kubelogin/releases/download/v#{version}/kubelogin-darwin-amd64.zip"
  sha256 "df65ee1200939c56d1ee0afdacbd7df4b1b9d70b3a8f2a8b50926372461f2e54"
  license "MIT"

  def install
    bin.install "darwin_amd64/kubelogin"
  end

  test do
    system bin/name, "version"
  end
end
