class Ferry < Formula
  include Language::Python::Virtualenv

  desc "Atlantis-style plan/apply/drift executor for Ansible"
  homepage "https://github.com/jfryman/ferry"
  url "https://github.com/jfryman/ferry/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "b8994fa787cdd4c3a4dad9162a0299c7c89629675cac29d91bfe2e6d7aeffafd"
  license "MIT"
  head "https://github.com/jfryman/ferry.git", branch: "main"

  depends_on "libyaml"
  depends_on "python@3.15"

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/76/b8/c0b780928e2fb1c87e9e375818c6f121da2398b071012d1747be300b83f4/pyyaml-6.0.4.tar.gz"
    sha256 "e24bf71af8a432d7808fabff134d38dfe16d3cbb41f2873bb4b1e42422de0a1a"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      `ferry run` calls `ansible-playbook` from your PATH. Install the ansible-core
      version your repository pins, for example:
        pipx install 'ansible-core~=2.20.0'

      `ferry run` also needs an identity token. By default it runs
        bao read -field=token identity/oidc/token/ferry
      so install and log in to the OpenBao CLI (`bao`) or the Vault CLI, or set
      FERRY_RUN_TOKEN_COMMAND to your own command.

      Docs: https://github.com/jfryman/ferry/blob/main/docs/run.md
    EOS
  end

  test do
    output = shell_output("#{bin}/ferry --help")
    assert_match "usage: ferry", output
    assert_match "run locally with a service-owned lock", output
    assert_match "--token-command", shell_output("#{bin}/ferry run --help")
  end
end
