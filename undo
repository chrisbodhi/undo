#!/bin/sh

# Check for api key first: OPENAI_API_KEY
if [ -z "$OPENAI_API_KEY" ]; then
  echo "OPENAI_API_KEY is not set; please see their docs on getting this key:"
  echo "https://help.openai.com/en/articles/4936850-where-do-i-find-my-secret-api-key"
  echo "Exiting."
  exit 1
fi

# We use jq for parsing the response
if which jq >/dev/null 2>&1; then
  continue
else
  echo "Please install jq before continuing."
  echo "https://stedolan.github.io/jq/download/"
  exit 1
fi

# Assume where we keep the history
LAST_COMMAND=$(cat ~/.zsh_history | tail -2 | head -1 | awk -F ";" '{print $2}')

PROMPT="Create a shell command that undoes the given command\n\nExample 1: mkdir new-directory\nOutput 1: rmdir new-directory\n##\nExample 2: git add .\nOutput 2: git reset HEAD~1\n##\nExample 3: $LAST_COMMAND\nOutput 3:"

if OUTPUT=$(curl https://api.openai.com/v1/completions \
      --silent \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $OPENAI_API_KEY" \
      -d "{
      \"model\": \"text-davinci-003\",
      \"prompt\": \"$PROMPT\",
      \"temperature\": 0,
      \"max_tokens\": 42,
      \"top_p\": 1,
      \"frequency_penalty\": 0.2,
      \"presence_penalty\": 0
    }"); then
    SUGGEST=$(echo $OUTPUT | jq '.choices[0].text' | sed -e 's/^\"//' -e 's/\"$//' -e 's/^ *//g' -e 's/ *$//g')
    echo "Press return to run:"
    read -p "$SUGGEST"
    eval "$SUGGEST"
else
    echo "Trouble getting a response rn."
    exit 1
fi
