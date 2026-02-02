# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/tinovyatkin/tally"
  license "Apache-2.0"
  version "0.4.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.4.1/tally_0.4.1_MacOS_arm64.tar.gz"
      sha256 "2b055e7e722d3769027527a6e2e373a7752b6570eb9b0af98549b3c0c81aa149"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.4.1/tally_0.4.1_MacOS_x86_64.tar.gz"
      sha256 "1514de0e59790eaf54ab7257c944522a48d5008acb4a6c0fcc796be118989bff"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tinovyatkin/tally/releases/download/v0.4.1/tally_0.4.1_Linux_arm64.tar.gz"
      sha256 "86d532380df2ecf941bb1385511874fc7570048ac183035568a50ff2cb8fdff3"
    else
      url "https://github.com/tinovyatkin/tally/releases/download/v0.4.1/tally_0.4.1_Linux_x86_64.tar.gz"
      sha256 "964b93046b8b51ef2c6317b73c71dbe0de03e716a5a92340d733b6a465090a6c"
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
