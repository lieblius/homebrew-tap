class GitAiCommit < Formula
  include Language::Python::Virtualenv
  
  desc "AI-powered git commit message generator using Claude"
  homepage "https://github.com/lieblius/git-ai-commit"
  url "https://github.com/lieblius/git-ai-commit/archive/refs/tags/0.0.1.tar.gz"
  sha256 "fdc8f9adbb66987eab240fcd773303189860e43722192be0c2f8a3692b1daa45"
  license "MIT"

  depends_on "poetry" => :build
  depends_on "python@3.11"
  depends_on "nvim"

  resource "anthropic" do
    url "https://files.pythonhosted.org/packages/3e/5c/b8fb1e7e851e7aebb39b1c04161ed5231cb0390b0c3e93d9f5fca5fb2d5b/anthropic-0.45.2.tar.gz"
    sha256 "69a3cfca1c85ca1d8c8b7605db3d21e506e4a5144ea8ccf79acaa93d41b5c99b"
  end

  def install
    virtualenv_create(libexec, "python3.11")
    system "poetry", "build", "--format=wheel"
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      You need to set your Anthropic API key:
        export ANTHROPIC_API_KEY=your_api_key_here
    EOS
  end

  test do
    # Basic help test
    system "#{bin}/gcai", "--help"
  end
end