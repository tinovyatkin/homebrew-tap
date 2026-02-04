# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/tinovyatkin/tally"
  license "Apache-2.0"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.6.0/tally_0.6.0_MacOS_arm64.tar.gz"
      sha256 "001bee88f580378d0e362fd76035e835db57d4f4bc9104ca9f7e19d47aea7b2f"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.6.0/tally_0.6.0_MacOS_x86_64.tar.gz"
      sha256 "17a7e100e7e3638331fda056ffa06a67c14f2aac9010124c7c170bb95dd4616b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.6.0/tally_0.6.0_Linux_arm64.tar.gz"
      sha256 "e562dc25ac23131fe2276e8318fea56eb5fe8b2e0f34d981185973437a1cb7ac"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.6.0/tally_0.6.0_Linux_x86_64.tar.gz"
      sha256 "02666c96577a65758ef05e82de3ce6e80872b950efc14bf03d7b2d8661c95a01"
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
