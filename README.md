# undo
## a command-line utility to suggest how to undo your last command

### Setup

- OpenAI key in an env var, `OPENAI_API_KEY`
    - Please see their docs on getting this key: https://help.openai.com/en/articles/4936850-where-do-i-find-my-secret-api-key

### Known limitations

- Only tested on macOS
- Do not send passwords, tokens, etc; we don't yet have any heuristics for warning about those
