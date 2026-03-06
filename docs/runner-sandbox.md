# Runner Sandbox

## Purpose

`Codie.Runner` validates learner submissions without executing code inside the main web request process.

## Current Approach

The runner currently:

1. parses the submitted Elixir code
2. rejects obviously blocked APIs
3. evaluates the code in a supervised task
4. captures stdout
5. checks the result against lesson rules
6. normalizes the outcome for the UI

## Result Types

- `:pass`
- `:fail_compile`
- `:fail_test`
- `:runtime_error`
- `:timeout`
- `:rejected_submission`
- `:runner_error`

## Guardrails

The current guardrails are intentionally lightweight and aimed at trusted local use:

- token-based blocking for dangerous APIs such as `System.cmd` and some file/process primitives
- timeout enforcement
- execution outside the main LiveView process
- module cleanup after evaluation

## Current Limits

This is not a hardened multi-tenant sandbox. It is suitable for:

- local development
- personal learning
- trusted user input

It is not suitable, as written, for public internet code execution.

## Next Hardening Steps

If you later expose this beyond local use, upgrade the runner to:

1. fork real OS processes per submission
2. isolate each submission in a temporary Mix project
3. apply OS-level CPU and memory limits
4. run under a reduced-privilege account or container
5. replace substring blocking with AST-level validation and process isolation
