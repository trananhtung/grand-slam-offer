#!/usr/bin/env bash
#
# Cài plugin/skill grand-slam-offer cho Claude Code và/hoặc OpenAI Codex.
# Dùng symlink trỏ về thư mục repo này, nên `git pull` là cập nhật ngay.
#
# Cách dùng:
#   ./install.sh            # cài cho cả hai (nếu phát hiện)
#   ./install.sh claude     # chỉ Claude Code
#   ./install.sh codex      # chỉ Codex
#   ./install.sh both       # cả hai
#
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-both}"

link() { # link <src> <dest>
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  rm -rf "$dest"
  ln -s "$src" "$dest"
  echo "  ↳ $dest -> $src"
}

install_claude() {
  echo "▶ Claude Code (~/.claude)"
  link "$REPO_DIR/skills/grand-slam-offer"          "$HOME/.claude/skills/grand-slam-offer"
  link "$REPO_DIR/commands/grand-slam-offer.md"     "$HOME/.claude/commands/grand-slam-offer.md"
  link "$REPO_DIR/commands/grand-slam-offer-auto.md" "$HOME/.claude/commands/grand-slam-offer-auto.md"
  echo "  ✅ Xong. Dùng: /grand-slam-offer hoặc /grand-slam-offer-auto"
}

install_codex() {
  echo "▶ Codex (~/.codex)"
  link "$REPO_DIR/skills/grand-slam-offer"                "$HOME/.codex/skills/grand-slam-offer"
  link "$REPO_DIR/codex/prompts/grand-slam-offer.md"      "$HOME/.codex/prompts/grand-slam-offer.md"
  link "$REPO_DIR/codex/prompts/grand-slam-offer-auto.md" "$HOME/.codex/prompts/grand-slam-offer-auto.md"
  echo "  ✅ Xong. Dùng: /grand-slam-offer hoặc /grand-slam-offer-auto (hoặc chỉ cần nói yêu cầu)"
}

case "$TARGET" in
  claude) install_claude ;;
  codex)  install_codex ;;
  both)
    installed=0
    if [ -d "$HOME/.claude" ] || command -v claude >/dev/null 2>&1; then install_claude; installed=1; fi
    if [ -d "$HOME/.codex" ]  || command -v codex  >/dev/null 2>&1; then install_codex;  installed=1; fi
    if [ "$installed" -eq 0 ]; then
      echo "Không phát hiện Claude Code hay Codex. Chạy: ./install.sh claude | codex"
      exit 1
    fi
    ;;
  *) echo "Tham số không hợp lệ: $TARGET (dùng: claude | codex | both)"; exit 1 ;;
esac

echo "Hoàn tất. Mở phiên mới của công cụ để nạp skill/lệnh."
