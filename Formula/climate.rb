# typed: false
# frozen_string_literal: true

# Homebrew formula for CLImate
# To use: brew tap jonw91/climate && brew install climate
class Climate < Formula
  desc "Cross-platform CLI weather forecast with ASCII art"
  homepage "https://github.com/JonW91/CLImate"
  version "0.1.13"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/JonW91/CLImate/releases/download/v#{version}/climate-osx-arm64.tar.gz"
      sha256 "e5e5b6ecac66e5626cf018dc98dbe4648d257bce77f0e001557c7f7637d1906e"
    end
    on_intel do
      url "https://github.com/JonW91/CLImate/releases/download/v#{version}/climate-osx-x64.tar.gz"
      sha256 "766b3b9880d069723dca478824410bca88a2f5168e147402a6155d9e5ea95d2c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/JonW91/CLImate/releases/download/v#{version}/climate-linux-arm64.tar.gz"
      sha256 "01d2f8ed3795797f889ed5cf7aeb71a27a3607c04b05027ae1a90d090b501108"
    end
    on_intel do
      url "https://github.com/JonW91/CLImate/releases/download/v#{version}/climate-linux-x64.tar.gz"
      sha256 "9cd27074a19d3779afd86ea6652fccd95f497d5979a0cf2ab75e0d029f66940e"
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
