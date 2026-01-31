# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/tinovyatkin/tally"
  license "Apache-2.0"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.2.0/tally_0.2.0_MacOS_arm64.tar.gz"
      sha256 "22c0acbe80ca7f24df08062d7a2cbafacbd3f129f2a6a3df6909580f4a7fec2e"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.2.0/tally_0.2.0_MacOS_x86_64.tar.gz"
      sha256 "32d98d54b15ac9ca800bcd9d6a158b72adec806c25f733523569b0c3df244b78"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.2.0/tally_0.2.0_Linux_arm64.tar.gz"
      sha256 "fe903769739697be6f16d423567a289a065b868958f7195f1d2d035be00fbe9c"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.2.0/tally_0.2.0_Linux_x86_64.tar.gz"
      sha256 "97aaa9d69ba5619aa7191cb1759e7d4e14e60a2d85ad03f1416d4a43fcbc231f"
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
