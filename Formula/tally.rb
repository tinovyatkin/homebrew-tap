# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/tinovyatkin/tally"
  license "Apache-2.0"
  version "0.8.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.8.0/tally_0.8.0_MacOS_arm64.tar.gz"
      sha256 "9e8ca4fc50c3ac86071fbf83bfe83df1f8e537fb94a740e4297d3b52db82c721"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.8.0/tally_0.8.0_MacOS_x86_64.tar.gz"
      sha256 "33e41e3546488fb7683c31c36d4b53566f72b458f1aea0eb73c842204e954eb5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.8.0/tally_0.8.0_Linux_arm64.tar.gz"
      sha256 "c27658d3de9a85456d77043bbe9bd8fd03b268b1bb0878416655f051b211eea4"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.8.0/tally_0.8.0_Linux_x86_64.tar.gz"
      sha256 "0be4ab13e4e1d825848d9d2ba3867f6cccf6332790c77a2df5eab8a8d2499f42"
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
