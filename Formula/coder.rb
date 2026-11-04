# Homebrew formula for the Coder CLI (tjcoder/cli).
#
# Install with:
#   brew tap tjcoder-labs/tap
#   brew install coder
#
# The formula downloads the platform-specific prebuilt release tarball
# from GitHub and installs the `coder` binary. The sha256 values below are
# for v0.9.253; regenerate them when bumping VERSION_TAG.
class Coder < Formula
  desc "Terminal-first AI coding assistant (TJ Coder / AI Labs)"
  homepage "https://github.com/tjcoder-labs/cli"
  version "0.9.253"
  license "MIT"

  VERSION_TAG = "v0.9.253"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tjcoder-labs/cli/releases/download/#{VERSION_TAG}/coder_#{VERSION_TAG}_darwin_arm64.tar.gz"
      sha256 "767b752b82342e4e7e8acb81d0c74f679643c4f40934d8794e9908fb090baf2f"
    else
      url "https://github.com/tjcoder-labs/cli/releases/download/#{VERSION_TAG}/coder_#{VERSION_TAG}_darwin_amd64.tar.gz"
      sha256 "3bcd9d78c6a467ba824fcb7327ddbe684ec24a184fc0e55d67d5187fec037909"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tjcoder-labs/cli/releases/download/#{VERSION_TAG}/coder_#{VERSION_TAG}_linux_arm64.tar.gz"
      sha256 "6f3fe09b969f28396d9372c997ded2e1a5a61e12af34b96c313fbd79051902f3"
    else
      url "https://github.com/tjcoder-labs/cli/releases/download/#{VERSION_TAG}/coder_#{VERSION_TAG}_linux_amd64.tar.gz"
      sha256 "3b26cc5a392aa1db2638300e8d663f9609783761d3b2b99d6adae86fc1bce3e4"
    end
  end

  head "https://github.com/tjcoder-labs/cli.git", branch: "main"

  depends_on "go" => :build if build.head?

  def install
    if build.head?
      system "make", "build"
      bin.install "bin/coder"
    else
      bin.install "coder"
    end
  end

  test do
    assert_match "coder", shell_output("#{bin}/coder --version 2>&1")
  end
end
