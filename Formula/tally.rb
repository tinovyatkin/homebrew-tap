# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/tinovyatkin/tally"
  license "Apache-2.0"
  version "0.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.7.0/tally_0.7.0_MacOS_arm64.tar.gz"
      sha256 "ffdaa1941d0973b57f2935ab79d1e7156e89266e8c534415df9fc7c82b96ed51"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.7.0/tally_0.7.0_MacOS_x86_64.tar.gz"
      sha256 "9b8ef9faa0694d5cfc53adda9856dbc2b4468abdbebeb2681d3d80e909dafb0d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.7.0/tally_0.7.0_Linux_arm64.tar.gz"
      sha256 "ce26629b2133c925a6517a6695a12ea8eb560a2d8d569cbfbe862cee00bdab6d"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.7.0/tally_0.7.0_Linux_x86_64.tar.gz"
      sha256 "b3016f440acc2d217f33b982718aec772f141f99fd03dc747aeff199ee62a88d"
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
