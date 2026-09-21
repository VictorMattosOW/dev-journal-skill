---
name: task-journal
description: Registro de tasks de desenvolvimento. Use quando o usuário disser "nova task", "começar task", "iniciar anotação de task", ou quando disser "documentar resolução", "fechar task", "finalizar task". Cria e preenche notas de diário de trabalho em Markdown com contexto, dificuldade, solução, arquivos alterados e lições aprendidas.
---

# Task Journal

Skill para registrar o processo de resolução de tasks de desenvolvimento em notas Markdown (importáveis no Notion, via frontmatter).

## Localizações

- Notas de tasks: o diretório `journal/` dentro do repo `dev-journal`. Para localizá-lo, verifique primeiro `~/dev-journal/journal/`; se não existir, procure o diretório `dev-journal` na home do usuário ou no projeto atual.
- Template: `TEMPLATE.md` no mesmo diretório desta SKILL.md.
- Script: `scripts/new-task.sh` no repo `dev-journal` (ex: `~/dev-journal/scripts/new-task.sh`).

## Comandos (gatilhos)

### 1. Iniciar uma task

Gatilhos de exemplo: "nova task: corrigir bug no login", "começar task de paginação", "iniciar anotação de task".

Passos:

1. Extraia o título da task a partir da mensagem do usuário.
2. Execute o script para gerar o arquivo (com slug e data automáticos):

```bash
bash ~/dev-journal/scripts/new-task.sh "<título da task>"
```

O script imprime o caminho do arquivo criado (ex: `journal/2026-09-21-corrigir-bug-login.md`).

3. Leia o arquivo gerado e pergunte ao usuário apenas o que ele **ainda não informou** explicitamente:
   - **Projeto** (repo/diretório onde a task será trabalhada)
   - **Contexto / Por quê** (o que motiva a task)
   - **Dificuldade estimada** (fácil | média | difícil)
   - **Abordagem planejada** (primeira hipótese de como resolver)
4. Preencha essas seções no arquivo. As seções pendentes permanecem `[pendente]`. O `status` continua `em-andamento`.
5. Confirme ao usuário com 1 linha: arquivo criado e o que falta preencher no fim.

### 2. Fechar/documentar uma task

Gatilhos de exemplo: "documentar resolução", "fechar task", "finalizar task".

Passos:

1. Encontre o arquivo da task em andamento: o mais recente em `journal/` com `status: em-andamento` (use `grep -l "status: em-andamento"` e ordene por data). Se houver mais de um, pergunte ao usuário qual fechar.
2. Revise o histórico da sessão atual e extraia fatos reais: arquivos editados/criados, comandos executados relevantes, erros encontrados e como foram contornados, decisões tomadas.
3. Preencha as seções:
   - **Solução final**: resumo objetivo do que foi feito para resolver.
   - **Arquivos alterados**: lista real (caminho relativo ao projeto).
   - **Erros e armadilhas**: problemas reais encontrados no caminho (se nenhum, escrever "nenhum").
   - **Lições aprendidas**: o que o usuário levaria de aprendizado. Se não for óbvio pela sessão, pergunte.
   - **Tempo gasto**: diferença entre `iniciado_em` (frontmatter) e o horário atual.
   - **Dificuldade real**: compare com a estimada; se não for inferível da sessão, pergunte ("achou mais fácil ou mais difícil do que esperava?").
4. Atualize o frontmatter: `status: concluída`, `dificuldade_real`, e adicione `concluido_em: <data e hora>`.
5. **Apresente um resumo e peça confirmação antes de salvar.** Após confirmado, finalize o arquivo.

## Regras

- Nunca invente fatos: registre apenas o que aconteceu na sessão ou foi dito pelo usuário. Quando algo não for inferível, pergunte.
- Nunca apague conteúdo já escrito nas notas; apenas adicione ou atualize campos `[pendente]` e o frontmatter.
- Escreva as notas em português brasileiro, tom objetivo e técnico.
- Comandos destrutivos (rm, resets) executados na sessão devem ser registrados na nota.
- Se o usuário pedir para exportar/organizar no Notion: lembrar que é só arrastar os `.md` para o Notion (o frontmatter vira propriedades da página).
