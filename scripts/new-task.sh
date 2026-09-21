#!/usr/bin/env bash
# Cria uma nova nota de task no journal a partir do TEMPLATE.md
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Uso: new-task.sh <título da task>" >&2
  exit 1
fi

TITULO="$*"

# Diretório raiz do repo (pai do diretório scripts/)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE="$REPO_DIR/skills/task-journal/TEMPLATE.md"
JOURNAL_DIR="$REPO_DIR/journal"

if [ ! -f "$TEMPLATE" ]; then
  echo "Erro: template não encontrado em $TEMPLATE" >&2
  exit 1
fi

mkdir -p "$JOURNAL_DIR"

DATA="$(date +%Y-%m-%d)"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M')"

# Slug: minúsculas, remove acentos, troca não-alfanuméricos por hífen
SLUG="$(printf '%s' "$TITULO" \
  | iconv -f UTF-8 -t ASCII//TRANSLIT 2>/dev/null \
  | tr '[:upper:]' '[:lower:]' \
  | sed 's/[^a-z0-9]\+/-/g; s/^-\+//; s/-\+$//')"

[ -z "$SLUG" ] && SLUG="task"

ARQUIVO="$JOURNAL_DIR/${DATA}-${SLUG}.md"

# Evita sobrescrever: adiciona sufixo se já existir
N=2
while [ -e "$ARQUIVO" ]; do
  ARQUIVO="$JOURNAL_DIR/${DATA}-${SLUG}-${N}.md"
  N=$((N+1))
done

sed -e "s/{{DATA}}/$DATA/g" \
    -e "s/{{TIMESTAMP}}/$TIMESTAMP/g" \
    -e "s/{{TITULO}}/$TITULO/g" \
    "$TEMPLATE" > "$ARQUIVO"

echo "$ARQUIVO"
