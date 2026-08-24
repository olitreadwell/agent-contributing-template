# Terraform notes

Exact commands come from the repository's own config (`versions.tf`,
`*.tfvars`, CI workflow). Match what is there.

- **Formatting**: `terraform fmt` is mandatory; never hand-align HCL.
- **Validation**: `terraform validate` before plan; `terraform plan` before
  apply. Never `apply` without a reviewed plan.
- **Modules**: respect the repo's module layout; do not inline a module the
  repo already wraps.
- **State**: never commit state files or `.terraform/`; follow the repo's
  remote-state convention.
- **Naming**: `snake_case` resource names, `camelCase` variable names, clear
  per-resource tags. Keep names greppable.
- **Variables**: declare variables and locals, never hardcode a value in a
  resource. Secrets via the repo's provider/backend, never in `*.tf`.
- **Providers**: versions pinned in the repo's lockfile; no floating
  `latest`.

## Common traps for agents

- Plan output vs. applied state: report what `terraform plan` said, not what
  you assume.
- Destroying or replacing resources: confirm the impact before a
  `-replace`, `destroy`, or `taint`; say what the escape hatch is.
- Formatting drift: run `terraform fmt` before committing.
- Leaving credentials or a `backend.tf` pointing at a real cloud in
  committed code.
