# Ansible notes

Exact commands come from the repository's own config (`ansible.cfg`,
`playbook*.yml`, roles layout). Match what is there.

- **YAML hygiene**: playbooks and roles are YAML; use the repo's lint
  (`ansible-lint`) and keep files machine-parseable.
- **Idempotency**: tasks must be runnable twice with the same result. Every
  task either reports `ok` or changes deliberately.
- **Structure**: respect the repo's layout (playbooks vs. roles vs.
  collections); do not invent a second structure.
- **Secrets**: vault-encrypt secrets via the repo's convention; never plain
  credentials in a playbook, inventory, or group_vars.
- **Naming**: `snake_case` task names that state the outcome ("Ensure nginx
  is installed"), not the mechanism.
- **Handlers and tags**: use the repo's existing handlers/tags; add only
  when the change genuinely needs them.

## Common traps for agents

- Non-idempotent tasks: `command` where a module (`apt`, `copy`,
  `template`, `service`) is the idempotent choice.
- Running against production inventory during development; respect the
  repo's environment separation.
- Inventing a new inventory file when the repo already has one.
- Editing a playbook without running `--check`/`--diff` first, or claiming a
  run succeeded when it did not.
