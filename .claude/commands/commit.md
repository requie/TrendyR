---
description: Creates a signed git commit with my identity
argument-hint: [commit message]
allowed-tools: Bash(git commit:*)
---
! git commit -S -m "$ARGUMENTS"
