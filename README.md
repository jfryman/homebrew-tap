# jfryman/tap

Homebrew formulae for [jfryman](https://github.com/jfryman) projects.

## ferry

[ferry](https://github.com/jfryman/ferry) is an Atlantis-style plan/apply/drift executor for
Ansible. The formula installs the `ferry` CLI, which is mainly used for
[`ferry run`](https://github.com/jfryman/ferry/blob/main/docs/run.md).

```bash
brew install jfryman/tap/ferry
```

Or tap the repository first:

```bash
brew tap jfryman/tap
brew install ferry
```

`ferry run` also needs:

- **`ansible-playbook` on your PATH.** The formula doesn't install Ansible, so you can use the
  `ansible-core` version your repository pins. Homebrew's `ansible` formula is the full
  community bundle with whatever `ansible-core` Homebrew currently ships. For example:
  `pipx install 'ansible-core~=2.20.0'`.
- **A way to get an identity token.** By default ferry runs
  `bao read -field=token identity/oidc/token/ferry`, so install and log in to the OpenBao CLI
  (`bao`) or the Vault CLI, or set `FERRY_RUN_TOKEN_COMMAND` to your own command.
- `git` and `ssh-keygen`, which macOS and most Linux systems already have.

The formula installs the CLI only. The `service` extra (cryptography, used by `ferry serve`)
isn't included; run the service from the container image `ghcr.io/jfryman/ferry`.

## How the formula is kept up to date

[`bump.yml`](.github/workflows/bump.yml) checks for a new ferry release every 6 hours. If there
is one and GitHub reports a verified signature on its tag, the workflow points the formula at
the new tag's source tarball and builds, tests and audits it on Linux and macOS. It then commits
the change to `main`. To run it now: **Actions → bump → Run workflow**.

GitHub turns off scheduled workflows in a public repository after 60 days without activity. If
that happens, re-enable `bump` from the Actions tab, or run it by hand after a release.

[`tests.yml`](.github/workflows/tests.yml) runs the same build, `brew test` and
`brew audit --strict --online` on every push and pull request.

## License

MIT. See [LICENSE](LICENSE).
