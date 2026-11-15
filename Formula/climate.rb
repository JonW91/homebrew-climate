# typed: false
# frozen_string_literal: true

# Homebrew formula for CLImate
# To use: brew tap jonw91/climate && brew install climate
class Climate < Formula
  desc "Cross-platform CLI weather forecast with ASCII art"
  homepage "https://github.com/JonW91/CLImate"
  version "0.1.14"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/JonW91/CLImate/releases/download/v#{version}/climate-osx-arm64.tar.gz"
      sha256 "453b5981331525ceff7478bf939819cbfad7a88d07aba70914e542afe9b5b870"
    end
    on_intel do
      url "https://github.com/JonW91/CLImate/releases/download/v#{version}/climate-osx-x64.tar.gz"
      sha256 "7658abc5d3d9ca6dafb216f981d1a338ee6c695d36fb2b72618f1928a25f22d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/JonW91/CLImate/releases/download/v#{version}/climate-linux-arm64.tar.gz"
      sha256 "b2cd8433798f45741bab8976ab2c77730c1a29c48c4b90dca1449fd7d5c8efd4"
    end
    on_intel do
      url "https://github.com/JonW91/CLImate/releases/download/v#{version}/climate-linux-x64.tar.gz"
      sha256 "201bd26573d2cd87c709bf5e8b7925aa75af3523a04d49f2d1c0a5cffe1f833b"
    end
  end

  def install
    # The binary loads Assets/ from its own directory, so keep them together
    # in libexec and expose a launcher in bin.
    libexec.install "climate", "Assets"
    bin.write_exec_script libexec/"climate"
  end

  def caveats
    <<~EOS
      CLImate has been installed!

      Usage:
        climate London
        climate --today Paris
        climate --hourly "New York"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/climate --version")
    assert_path_exists libexec/"Assets/ascii-art.json"
  end
end
