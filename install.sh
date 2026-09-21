#!/usr/bin/env bash
# Instala a skill task-journal para Claude Code e OpenCode (agentes)
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="$REPO_DIR/skills/task-journal"

if [ ! -f "$SKILL_SRC/SKILL.md" ]; then
  echo "Erro: SKILL.md não encontrado em $SKILL_SRC" >&2
  exit 1
fi

install_skill() {
  local dest="$1/task-journal"
  mkdir -p "$dest"
  cp "$SKILL_SRC/SKILL.md" "$SKILL_SRC/TEMPLATE.md" "$dest/"
  echo "Instalado em: $dest"
}

install_skill "$HOME/.claude/skills"
install_skill "$HOME/.agents/skills"

echo ""
echo "Instalação concluída. Gatilhos:"
echo "  - 'nova task: <título>'  -> cria a nota da task"
echo "  - 'documentar resolução' -> fecha a task preenchendo a nota"
