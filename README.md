# dev-journal

Diário de tasks de desenvolvimento com uma skill de agente que registra
contexto, dificuldade, solução e lições aprendidas de cada task.

## Estrutura

```
skills/task-journal/   # SKILL.md + TEMPLATE.md (a skill em si)
scripts/new-task.sh    # cria nota de task (data + slug automáticos)
journal/               # suas notas ficam aqui
install.sh             # instala a skill nos CLIs
```

## Instalação (numa máquina nova)

```bash
git clone <url-do-repo> ~/dev-journal
cd ~/dev-journal
./install.sh
```

Isso instala a skill nos dois lugares:

- `~/.claude/skills/task-journal/` (Claude Code)
- `~/.agents/skills/task-journal/` (OpenCode)

## Uso

Dentro de uma sessão do agente:

- **Começar:** `nova task: corrigir bug no login`
  → o agente cria `journal/2026-09-21-corrigir-bug-login.md` e pergunta
  contexto, dificuldade estimada e abordagem planejada.
- **Trabalhar** na task normalmente.
- **Fechar:** `documentar resolução`
  → o agente revisa o que foi feito na sessão e preenche solução final,
  arquivos alterados, erros/armadilhas, lições e tempo gasto. Você confirma
  antes de salvar.

Também dá para criar a nota manualmente:

```bash
~/dev-journal/scripts/new-task.sh "investigar lentidão na query de pedidos"
```

## Importar no Notion

Arraste os arquivos `.md` de `journal/` para uma página do Notion. O
frontmatter (data, projeto, dificuldade, status) vira propriedades da página.

## Versionamento

Recomendado: commitar as notas junto com a skill neste mesmo repo, para ter
histórico e acesso de qualquer máquina.
