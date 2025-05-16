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
    url "https://files.pythonhosted.org/packages/15/74/2b2485fc120da834c0c5be07462541ec082e9fa8851d845f2587e480535a/anthropic-0.45.2.tar.gz"
    sha256 "32a18b9ecd12c91b2be4cae6ca2ab46a06937b5aa01b21308d97a6d29794fb5e"
  end

  def install
    # Create virtual environment
    venv = virtualenv_create(libexec, "python3.11")
    
    # Install anthropic directly
    venv.pip_install resource("anthropic")
    
    # Install the package
    venv.pip_install_and_link buildpath
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