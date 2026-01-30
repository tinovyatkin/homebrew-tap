# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/tinovyatkin/tally"
  license "Apache-2.0"
  version "0.1.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.1.5/tally_0.1.5_MacOS_arm64.tar.gz"
      sha256 "9e7c82259039b4aebf79f95c26ebeed0849fed602fc47aae82d0c14a8426754d"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.1.5/tally_0.1.5_MacOS_x86_64.tar.gz"
      sha256 "ddf97e09fedda4e3ac7ba76d368b5a150567f1b62c9ad11799fa7ceb4b1b0362"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.1.5/tally_0.1.5_Linux_arm64.tar.gz"
      sha256 "68033e63101044f2ceea498a30eff799781782f711eff29bddb9f88f268a6e9a"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.1.5/tally_0.1.5_Linux_x86_64.tar.gz"
      sha256 "8e0771d19ad35b03150a3d8decfc130f7f26e9be5c165aaa66895052ee4b918a"
    end
  end

  def install
    bin.install "tally"
  end

  test do
    # Create a simple Dockerfile to test
    (testpath/"Dockerfile").write <<~DOCKERFILE
      FROM alpine:latest
      RUN echo "hello"
    DOCKERFILE

    # Run tally and check it executes successfully
    output = shell_output("#{bin}/tally check #{testpath}/Dockerfile --format json")
    assert_match "files_scanned", output

    # Verify version output
    assert_match version.to_s, shell_output("#{bin}/tally version")
  end
end
