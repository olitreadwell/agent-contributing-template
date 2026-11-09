# 08 — Verification (prove the change works)

## The proof

- State exactly what you ran: the command, the environment, the result.
- A check that was not run is not evidence. Name what you ran and what it
  produced.
- If a gate is advisory in this repo, say which and do not treat it as
  proof.

## Order of evidence (strongest first)

1. Automated tests: the suite for the change passes, from specific to
   broad.
2. Build and static checks: the repo's check command passes clean.
3. Manual reproduction: a reproducible script or steps you ran, with the
   output captured.
4. Review: a human (or a second agent) read the diff and confirmed the
   change and the verification.

## When you cannot verify

- Say so plainly. "Not verified" is a state, not a failure.
- State what the remaining risk is and what would verify it.
- Do not mark a PR ready when verification is missing; say what is missing
  and why.

## Browser evidence for PRs

Trigger: the diff changes anything a user clicks, types into, or waits for.

- Drive the changed flow in a real browser with Playwright, on the final code.
- Record one continuous run of the full flow, start to finish.
- Convert the recording to a GIF under 10 MB so GitHub renders it inline.
- Put it in an `## Evidence` section in the PR description.
- If a step cannot be verified, write `Unverified: <reason>` there.
- No interactive surface means no recording. Write
  `no browser evidence: <reason>` in the Evidence section.

## Golden rules

- Never report a result you did not observe. No "this should pass".
- Never delete or weaken a check and call the result a pass.
- Reproduce once from a clean state before claiming "works on my machine"
  matters to anyone else.
