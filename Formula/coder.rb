# Homebrew formula for the Coder CLI (tjcoder/cli).
#
# Install with:
#   brew tap tjcoder-labs/tap
#   brew install coder
#
# The formula downloads the platform-specific prebuilt release tarball
# from GitHub and installs the `coder` binary. The sha256 values below are
# for v0.9.266; regenerate them when bumping VERSION_TAG.
class Coder < Formula
  desc "Terminal-first AI coding assistant (TJ Coder / AI Labs)"
  homepage "https://github.com/tjcoder-labs/cli"
  version "0.9.266"
  license "MIT"

  VERSION_TAG = "v0.9.266"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tjcoder-labs/cli/releases/download/#{VERSION_TAG}/coder_#{VERSION_TAG}_darwin_arm64.tar.gz"
      sha256 "75e1ef80b85087385d08cda87d0635600dff9031300df3073af47b53c7255321"
    else
      url "https://github.com/tjcoder-labs/cli/releases/download/#{VERSION_TAG}/coder_#{VERSION_TAG}_darwin_amd64.tar.gz"
      sha256 "2d00602ed06d6a8c10b97e2c19cb0b537eeab9a85e0311ed0377d93bc5b8b3d9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tjcoder-labs/cli/releases/download/#{VERSION_TAG}/coder_#{VERSION_TAG}_linux_arm64.tar.gz"
      sha256 "204f86d0e082cdba46eef5699bbe505d0f4fc665135522e8754ae01ce3ddca70"
    else
      url "https://github.com/tjcoder-labs/cli/releases/download/#{VERSION_TAG}/coder_#{VERSION_TAG}_linux_amd64.tar.gz"
      sha256 "c62673050c735db90a5ba58c310f1fed5100e617e3bc4cb8fd112e2947bdec62"
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
