# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/tinovyatkin/tally"
  license "Apache-2.0"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.5.0/tally_0.5.0_MacOS_arm64.tar.gz"
      sha256 "633b0b2f62ae93c7c65fdee306f77b4bbd064ea97082d32f58894490051aea25"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.5.0/tally_0.5.0_MacOS_x86_64.tar.gz"
      sha256 "3a5d37ea224eefb4a445babce73f5a7c97457a9aee275cb40e7967f5ec3a5035"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.5.0/tally_0.5.0_Linux_arm64.tar.gz"
      sha256 "9675f1586aee533799620d5018e6c0f47924b36957b33a23224f706688b254d7"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.5.0/tally_0.5.0_Linux_x86_64.tar.gz"
      sha256 "ffd1f3c5a187c973f5dbe7c42c7da4f144996123bfa1ba68552665b4862ffdfa"
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
