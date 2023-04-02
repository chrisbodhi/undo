# undo
## a command-line utility to suggest how to undo your last command

### Setup

- OpenAI key in an env var, `OPENAI_API_KEY`
    - Please see their docs on getting this key: https://help.openai.com/en/articles/4936850-where-do-i-find-my-secret-api-key
- Depends on `jq`
- Reads history from `~/.zsh_history`

### Known limitations

- Do not send passwords, tokens, etc; we don't yet have any heuristics for warning about those
- Only tested on macOS with Zsh
