#!/bin/sh

set -e

SSH_PATH="$HOME/.ssh"

mkdir -p "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

echo "$INPUT_PRIVATE_KEY" > "$SSH_PATH/deploy_key"
echo "$INPUT_PUBLIC_KEY" > "$SSH_PATH/deploy_key.pub"

cat "$SSH_PATH/deploy_key"

chmod 700 "$SSH_PATH"
chmod 700 "$SSH_PATH/known_hosts"
chmod 700 "$SSH_PATH/deploy_key"
chmod 700 "$SSH_PATH/deploy_key.pub"

eval "$(ssh-agent)"
ssh-add "$SSH_PATH/deploy_key"

ssh-keyscan -t rsa "$INPUT_HOST" >> "$SSH_PATH/known_hosts"

git remote -v

git branch

GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" 

DOKKU_APP_URL=ssh://dokku@"$INPUT_HOST"/"$INPUT_PROJECT"

echo "$DOKKU_APP_URL"

git push "$DOKKU_APP_URL" "$INPUT_BRANCH"
