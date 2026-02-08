# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/tinovyatkin/tally"
  license "Apache-2.0"
  version "0.6.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.6.1/tally_0.6.1_MacOS_arm64.tar.gz"
      sha256 "099e6c462dc213ab80a60cd8622a90efc6980473439ba7f3fa7d720a8388645f"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.6.1/tally_0.6.1_MacOS_x86_64.tar.gz"
      sha256 "a5316e7fb9eaeeae8964aa9bd51591b31681bedade4e390e94b529e770a1e0a6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.6.1/tally_0.6.1_Linux_arm64.tar.gz"
      sha256 "e79b2d3494c993424b0f411e822add7984722fa59f7b5d6cc87edbb15c1739cf"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.6.1/tally_0.6.1_Linux_x86_64.tar.gz"
      sha256 "dbf89fedcf7866452697152b19dbc294864ad8884e02c78dbb979c9e06e96210"
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
