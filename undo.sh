#!/bin/sh

# Check for api key first: OPENAI_API_KEY
if [ -z "$OPENAI_API_KEY" ]; then
  echo "OPENAI_API_KEY is not set; please see their docs on getting this key:"
  echo "https://help.openai.com/en/articles/4936850-where-do-i-find-my-secret-api-key"
  echo "Exiting."
  exit 1
fi

# LAST_COMMAND=$(history | tail -1 | cut -d' ' -f 5-)
# LAST_COMMAND="git commit -m 'track password file'"
LAST_COMMAND="touch README.mdd"
# LAST_DIRECTORY=$OLDPWD
OS='macOS'
SHELL=$SHELL
# PROMPT="Using the terminal on $OS with zsh, I ran the command '$LAST_COMMAND'. To undo that action, I type\n\n$"

# PROMPT="# Write a shell command that will undo the command, \`$LAST_COMMAND\`\n\n$"
PROMPT="Create a shell command that undoes the given command\n\nExample: mkdir new-directory\nOutput: rmdir new-directory\n\nExample: git add .\nOutput: git reset\n\n$LAST_COMMAND\n"

echo "$PROMPT"

if OUTPUT=$(curl https://api.openai.com/v1/completions \
        --silent \
        -H 'Content-Type: application/json' \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d '{
        "model": "text-davinci-003",
        "prompt": "$PROMPT",
        "max_tokens": 11,
        "temperature": 0.2,
        "top_p": 1,
        "frequency_penalty": 0.2,
        "presence_penalty": 0
    }'); then
    echo "got output"
    echo $OUTPUT
else
    echo "Trouble getting a response rn."
    exit 1
fi
