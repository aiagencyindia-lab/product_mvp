#!/bin/bash
set -e

echo "==> Setting up Orion workspace..."

mkdir -p /root/.openclaw/workspace/skills
mkdir -p /root/.openclaw/workspace/pm
mkdir -p /root/.openclaw/workspace/social
mkdir -p /root/.openclaw/workspace/finance
mkdir -p /root/.openclaw/credentials

# Copy agent skill files into openclaw workspace
cp -r /app/agents/* /root/.openclaw/workspace/skills/

# Initialise task backlog if it doesn't exist
if [ ! -f /root/.openclaw/workspace/pm/backlog.md ]; then
  echo "# Task Backlog\n\n| ID | Task | Due | Status |\n|---|---|---|---|\n" \
    > /root/.openclaw/workspace/pm/backlog.md
fi

# Initialise expense ledger
if [ ! -f /root/.openclaw/workspace/finance/expenses.csv ]; then
  echo "date,description,amount,currency,category" \
    > /root/.openclaw/workspace/finance/expenses.csv
fi

echo "==> Orion workspace ready."
