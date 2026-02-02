# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/tinovyatkin/tally"
  license "Apache-2.0"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.4.0/tally_0.4.0_MacOS_arm64.tar.gz"
      sha256 "1d6bff12aa7c3abc197bdbd5886e1bae6c80329ea7c7220d0009651999810ebf"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.4.0/tally_0.4.0_MacOS_x86_64.tar.gz"
      sha256 "7fb276f0f6f2ee39f828be67fae1858e8c703c655dba3e9eaf63f43d84c6d1e4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.4.0/tally_0.4.0_Linux_arm64.tar.gz"
      sha256 "f972ec775b85c7a359f60162a980856c4ad9b3d0fb775b9a611ffcc56c319cec"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.4.0/tally_0.4.0_Linux_x86_64.tar.gz"
      sha256 "ad492bae22aa05649c3147affad6fade31a71796a18f3d5d87545eb104ddaefb"
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
