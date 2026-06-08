# Claude Code Preferences & Working Style

## Communication Style
  - **Language**: English, unless prompt is mainly in spanish.
- **Tone**: Terse, direct, no fluff
- **Output**: Show diffs and changes; don't narrate what was done
- **Summaries**: Omit end-of-turn summaries — the user can read the diff
- **Explanations**: Show results, not process; one sentence updates at key moments only

## Task Approach
- **Scope**: Don't add features beyond what's requested; no premature abstractions
- **Error Handling**: Only validate at system boundaries (user input, external APIs); trust internal guarantees
- **Code Comments**: Minimal — only when the WHY is non-obvious (hidden constraint, subtle invariant, workaround)
- **Testing**: For UI/frontend changes, verify in browser before reporting done
- **Git**: The User will take care of this

## Working with Memory
- **Engram**: Proactively save decisions, bugs, discoveries, and conventions — don't wait to be asked
- **Future Sessions**: Check memory before starting work on a familiar topic

## External Integrations
- **No unsolicited URLs**: Never generate URLs unless confident they help with programming
- **GitHub/CLI**: Use `gh` for GitHub operations; check authorization context for dual-use security tools

@RTK.md
