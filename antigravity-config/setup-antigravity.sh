#!/usr/bin/env bash
# Script to initialize Antigravity CLI YOLO Mode & Rules on NixOS

set -e

AGY_DIR="$HOME/.gemini/antigravity-cli"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Setting up Antigravity CLI Autonomous (YOLO Mode) Configuration..."

mkdir -p "$AGY_DIR/rules"

cp "$SCRIPT_DIR/settings.json" "$AGY_DIR/settings.json"
cp "$SCRIPT_DIR/GEMINI.md" "$AGY_DIR/GEMINI.md"
cp -r "$SCRIPT_DIR/rules/"* "$AGY_DIR/rules/"

echo "✅ Antigravity CLI rules, YOLO permissions ('always-proceed'), and settings successfully installed to $AGY_DIR!"
