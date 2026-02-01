# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/tinovyatkin/tally"
  license "Apache-2.0"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.3.0/tally_0.3.0_MacOS_arm64.tar.gz"
      sha256 "afc9970df04f05d117137acb6137e051652fc71b823b59412423fe85f38a808c"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.3.0/tally_0.3.0_MacOS_x86_64.tar.gz"
      sha256 "3721dd877fd45eddc8f25abd8a3a4b7344a97f75b28235ce69ff400e60340665"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.3.0/tally_0.3.0_Linux_arm64.tar.gz"
      sha256 "3492c4c512e9ca885629dcf9bc97438b6553aa903139f873c6bf4788a6f71eed"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.3.0/tally_0.3.0_Linux_x86_64.tar.gz"
      sha256 "1b8bf7087c6d7066ddfec7a6f357caca7972859423637b2c51635d05e9132c08"
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
