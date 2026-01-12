# 🗺️ Keymaps - Guia de Sobrevivência

> *"No Vim, você não edita texto. Você **compõe ações** sobre movimentos."*

Este guia foi feito para quem está começando no Neovim + iTerm2. 
Não precisa decorar tudo — use como referência no dia a dia! 📚

---

## 📖 Índice

1. [🧠 A Filosofia do Vim](#-a-filosofia-do-vim)
2. [🎮 Modos do Vim](#-modos-do-vim)
3. [🚶 Movimentação Básica](#-movimentação-básica)
4. [✂️ Edição de Texto](#️-edição-de-texto)
5. [🔍 Busca e Substituição](#-busca-e-substituição)
6. [💾 Arquivos e Buffers](#-arquivos-e-buffers)
7. [🪟 Janelas e Splits](#-janelas-e-splits)
8. [🔌 Plugins Essenciais](#-plugins-essenciais)
9. [🦎 Conjure (REPL Clojure)](#-conjure-repl-clojure)
10. [🖥️ iTerm2](#️-iterm2)
11. [⌨️ Terminal & Shell](#️-terminal--shell)
12. [🎯 Workflow Diário](#-workflow-diário)

---

## 🧠 A Filosofia do Vim

O Vim usa uma gramática simples:

```
[número] + [ação] + [movimento]
```

### Exemplos práticos:

| Comando | Tradução | O que faz |
|---------|----------|-----------|
| `dw` | **d**elete **w**ord | Apaga até próxima palavra |
| `d3w` | **d**elete **3** **w**ords | Apaga 3 palavras |
| `ci"` | **c**hange **i**nside **"** | Muda texto dentro das aspas |
| `yap` | **y**ank **a** **p**aragraph | Copia um parágrafo |
| `>}` | indent até próximo **}** | Indenta até fechar bloco |

### 🔑 Ações principais:

| Tecla | Ação | Mnemônico |
|-------|------|-----------|
| `d` | Delete (cortar) | **d**elete |
| `y` | Yank (copiar) | **y**ank |
| `c` | Change (mudar) | **c**hange |
| `v` | Visual (selecionar) | **v**isual |
| `>` | Indentar → | |
| `<` | Indentar ← | |

### 🎯 Movimentos principais:

| Tecla | Movimento | Mnemônico |
|-------|-----------|-----------|
| `w` | Próxima palavra | **w**ord |
| `b` | Palavra anterior | **b**ack |
| `e` | Fim da palavra | **e**nd |
| `0` | Início da linha | |
| `$` | Fim da linha | |
| `gg` | Início do arquivo | |
| `G` | Fim do arquivo | |
| `{` | Parágrafo anterior | |
| `}` | Próximo parágrafo | |

### 🎁 Text Objects (objetos de texto):

| Objeto | Descrição | Exemplo |
|--------|-----------|---------|
| `iw` | **i**nner **w**ord | `diw` → apaga palavra |
| `aw` | **a** **w**ord (com espaço) | `daw` → apaga palavra + espaço |
| `i"` | **i**nside **"** | `ci"` → muda dentro de aspas |
| `a"` | **a**round **"** | `da"` → apaga incluindo aspas |
| `ip` | **i**nner **p**aragraph | `yip` → copia parágrafo |
| `i(` | **i**nside **(** | `di(` → apaga dentro de () |
| `it` | **i**nner **t**ag | `cit` → muda dentro de tag HTML |

> 💡 **Dica de ouro:** `i` = dentro, `a` = ao redor (inclui delimitadores)

---

## 🎮 Modos do Vim

O Vim tem diferentes "modos" de operação:

```
┌─────────────────────────────────────────────────────┐
│                    NORMAL MODE                       │
│              (onde você passa mais tempo)            │
│                                                      │
│     i,a,o,O ↓              ↓ v,V,Ctrl+v              │
│   ┌──────────────┐    ┌──────────────┐              │
│   │ INSERT MODE  │    │ VISUAL MODE  │              │
│   │  (digitar)   │    │  (selecionar)│              │
│   └──────────────┘    └──────────────┘              │
│          ↑ Esc              ↑ Esc                   │
│                                                      │
│                    : ↓                               │
│            ┌──────────────┐                          │
│            │ COMMAND MODE │                          │
│            │  (comandos)  │                          │
│            └──────────────┘                          │
│                  ↑ Esc/Enter                         │
└─────────────────────────────────────────────────────┘
```

### Entrando no modo INSERT:

| Tecla | O que faz | Quando usar |
|-------|-----------|-------------|
| `i` | Insert antes do cursor | Editar no meio |
| `a` | Append depois do cursor | Continuar escrevendo |
| `I` | Insert no início da linha | Adicionar no começo |
| `A` | Append no final da linha | Adicionar no fim |
| `o` | Nova linha abaixo | Nova linha + editar |
| `O` | Nova linha acima | Inserir linha antes |

> 💡 **Macete:** Maiúscula = extremos da linha, Minúscula = relativo ao cursor

### Saindo do modo INSERT:

| Tecla | Ação |
|-------|------|
| `Esc` | Volta pro Normal mode |
| `Ctrl + [` | Mesmo que Esc (mais ergonômico) |
| `Ctrl + c` | Mesmo que Esc |

---

## 🚶 Movimentação Básica

### Movimento por caractere (use quando precisar de precisão):

```
          ↑
          k
    ← h       l →      💡 Dica: j parece uma seta ↓
          j
          ↓
```

### Movimento por palavra:

| Tecla | Movimento | Exemplo |
|-------|-----------|---------|
| `w` | Início da próxima palavra | `the_quick_brown` → vai para `_` |
| `W` | Próxima PALAVRA (ignora pontuação) | `the_quick_brown` → pula tudo |
| `b` | Volta uma palavra | Oposto de `w` |
| `B` | Volta uma PALAVRA | Oposto de `W` |
| `e` | Fim da palavra atual | Para no último caractere |
| `E` | Fim da PALAVRA | |

### Movimento por linha:

| Tecla | Vai para |
|-------|----------|
| `0` | Primeiro caractere da linha |
| `^` | Primeiro caractere não-branco |
| `$` | Último caractere da linha |
| `g_` | Último caractere não-branco |

### Movimento por arquivo:

| Tecla | Vai para |
|-------|----------|
| `gg` | Primeira linha |
| `G` | Última linha |
| `{número}G` | Linha específica (ex: `50G`) |
| `{número}gg` | Mesma coisa |
| `Ctrl + g` | Mostra posição atual |

### Movimento por tela:

| Tecla | Movimento |
|-------|-----------|
| `Ctrl + d` | Meia página ↓ (**d**own) |
| `Ctrl + u` | Meia página ↑ (**u**p) |
| `Ctrl + f` | Página inteira ↓ (**f**orward) |
| `Ctrl + b` | Página inteira ↑ (**b**ack) |
| `H` | Topo da tela (**H**igh) |
| `M` | Meio da tela (**M**iddle) |
| `L` | Fim da tela (**L**ow) |
| `zz` | Centraliza linha atual |
| `zt` | Linha atual no topo |
| `zb` | Linha atual embaixo |

### Movimento por bloco/parágrafo:

| Tecla | Movimento |
|-------|-----------|
| `{` | Parágrafo anterior |
| `}` | Próximo parágrafo |
| `%` | Par correspondente `()` `[]` `{}` |

---

## ✂️ Edição de Texto

### Deletar (cortar para clipboard):

| Comando | O que faz |
|---------|-----------|
| `x` | Deleta caractere sob cursor |
| `X` | Deleta caractere antes do cursor |
| `dd` | Deleta linha inteira |
| `D` | Deleta até fim da linha (= `d$`) |
| `dw` | Deleta até próxima palavra |
| `de` | Deleta até fim da palavra |
| `diw` | Deleta palavra (inner word) |
| `daw` | Deleta palavra + espaço |
| `di"` | Deleta dentro das aspas |
| `da"` | Deleta incluindo aspas |
| `dip` | Deleta parágrafo |
| `d}` | Deleta até próximo parágrafo |
| `dG` | Deleta até fim do arquivo |
| `dgg` | Deleta até início do arquivo |

### Copiar (yank):

| Comando | O que faz |
|---------|-----------|
| `yy` | Copia linha inteira |
| `Y` | Copia linha inteira |
| `yw` | Copia palavra |
| `yiw` | Copia palavra (inner) |
| `yi"` | Copia dentro das aspas |
| `yip` | Copia parágrafo |
| `y$` | Copia até fim da linha |

### Colar:

| Comando | O que faz |
|---------|-----------|
| `p` | Cola depois do cursor/linha |
| `P` | Cola antes do cursor/linha |

### Mudar (change = delete + insert):

| Comando | O que faz |
|---------|-----------|
| `cc` | Muda linha inteira |
| `C` | Muda até fim da linha (= `c$`) |
| `cw` | Muda palavra |
| `ciw` | Muda palavra inteira |
| `ci"` | Muda dentro das aspas |
| `ci(` | Muda dentro dos parênteses |
| `cit` | Muda dentro da tag HTML |
| `ct,` | Muda até a vírgula |

### Substituir:

| Comando | O que faz |
|---------|-----------|
| `r{char}` | Substitui caractere sob cursor |
| `R` | Modo Replace (sobrescreve) |
| `~` | Troca maiúscula/minúscula |

### Desfazer/Refazer:

| Comando | O que faz |
|---------|-----------|
| `u` | Desfaz última ação |
| `U` | Desfaz todas mudanças na linha |
| `Ctrl + r` | Refaz (redo) |
| `.` | Repete última ação ✨ |

> 💡 **Super dica:** O `.` é mágico! Fez `ciw` e mudou uma palavra? Vai para outra e aperta `.` para repetir!

### Indentação:

| Comando | O que faz |
|---------|-----------|
| `>>` | Indenta linha → |
| `<<` | Desindenta linha ← |
| `==` | Auto-indenta linha |
| `gg=G` | Auto-indenta arquivo inteiro |

---

## 🔍 Busca e Substituição

### Buscar:

| Comando | O que faz |
|---------|-----------|
| `/texto` | Busca "texto" para frente |
| `?texto` | Busca "texto" para trás |
| `n` | Próxima ocorrência |
| `N` | Ocorrência anterior |
| `*` | Busca palavra sob cursor → |
| `#` | Busca palavra sob cursor ← |
| `:noh` | Limpa highlight da busca |

### Substituir:

| Comando | O que faz |
|---------|-----------|
| `:s/old/new` | Substitui primeiro na linha |
| `:s/old/new/g` | Substitui todos na linha |
| `:%s/old/new/g` | Substitui em todo arquivo |
| `:%s/old/new/gc` | Substitui com confirmação |
| `:#,#s/old/new/g` | Substitui entre linhas # e # |

### Flags de substituição:

| Flag | Significado |
|------|-------------|
| `g` | **g**lobal (todos na linha) |
| `c` | **c**onfirm (pede confirmação) |
| `i` | **i**gnore case |
| `I` | case sensitive |

---

## 💾 Arquivos e Buffers

### Comandos básicos:

| Comando | O que faz |
|---------|-----------|
| `:w` | Salva arquivo |
| `:q` | Fecha (sai) |
| `:wq` ou `:x` | Salva e fecha |
| `:q!` | Fecha sem salvar |
| `:qa` | Fecha todas as janelas |
| `:qa!` | Fecha tudo sem salvar |
| `:e arquivo` | Abre arquivo |
| `:e!` | Recarrega arquivo (descarta mudanças) |

### Buffers:

Buffers são arquivos abertos na memória.

| Comando | O que faz |
|---------|-----------|
| `:ls` ou `:buffers` | Lista buffers |
| `:b {número}` | Vai para buffer |
| `:bn` | Buffer **n**ext |
| `:bp` | Buffer **p**revious |
| `:bd` | Buffer **d**elete (fecha) |

### Com Space como Leader (config do Sanctum):

| Atalho | O que faz |
|--------|-----------|
| `Space + ,` | Lista buffers (Telescope) |
| `Space + ll` | Próximo buffer |
| `Space + hh` | Buffer anterior |
| `Space + k` | Fecha buffer |
| `Space + bd` | Fecha buffers ocultos |

---

## 🪟 Janelas e Splits

### Criar splits:

| Comando | O que faz |
|---------|-----------|
| `:sp` ou `Ctrl+w s` | Split **h**orizontal |
| `:vsp` ou `Ctrl+w v` | Split **v**ertical |
| `:sp arquivo` | Split + abre arquivo |

### Navegar entre janelas:

| Comando | Vai para janela |
|---------|-----------------|
| `Ctrl + w h` | ← esquerda |
| `Ctrl + w j` | ↓ abaixo |
| `Ctrl + w k` | ↑ acima |
| `Ctrl + w l` | → direita |
| `Ctrl + w w` | Próxima janela |

### Gerenciar janelas:

| Comando | O que faz |
|---------|-----------|
| `Ctrl + w q` | Fecha janela |
| `Ctrl + w o` | Fecha todas exceto atual |
| `Ctrl + w =` | Iguala tamanhos |
| `Ctrl + w _` | Maximiza altura |
| `Ctrl + w |` | Maximiza largura |
| `Ctrl + w T` | Move para nova tab |

### Com config do Sanctum:

| Atalho | O que faz |
|--------|-----------|
| `Ctrl + h` | Janela ← |
| `Ctrl + j` | Janela ↓ |
| `Ctrl + k` | Janela ↑ |
| `Ctrl + l` | Janela → |

---

## 🔌 Plugins Essenciais

### 🌳 NvimTree (Árvore de Arquivos)

| Atalho | O que faz |
|--------|-----------|
| `Space + n` | Toggle árvore |
| `Ctrl + n` | Encontra arquivo atual na árvore |

**Dentro da árvore:**

| Tecla | O que faz |
|-------|-----------|
| `Enter` | Abre arquivo/pasta |
| `a` | Cria arquivo/pasta |
| `d` | Deleta |
| `r` | Renomeia |
| `R` | Refresh |
| `q` | Fecha árvore |
| `v` | Abre em split vertical |
| `s` | Abre em split horizontal |
| `H` | Toggle arquivos ocultos |
| `I` | Toggle .gitignore |

### 🔭 Telescope (Busca Fuzzy)

| Atalho | O que faz |
|--------|-----------|
| `Space + ff` | **F**ind **f**iles (busca arquivos) |
| `Space + fg` | **F**ind by **g**rep (busca texto) |
| `Space + fh` | **F**ind **h**elp |
| `Space + ,` | Buffers abertos |

**Dentro do Telescope:**

| Tecla | O que faz |
|-------|-----------|
| `Ctrl + j/k` | Navega resultados |
| `Enter` | Abre selecionado |
| `Ctrl + v` | Abre em split vertical |
| `Ctrl + x` | Abre em split horizontal |
| `Esc` | Fecha |

### 😺 LazyGit

| Atalho | O que faz |
|--------|-----------|
| `Space + gg` | Abre LazyGit |

**Dentro do LazyGit:**

| Tecla | O que faz |
|-------|-----------|
| `?` | Ajuda |
| `q` | Sair |
| `space` | Stage/unstage arquivo |
| `a` | Stage all |
| `c` | Commit |
| `P` | Push |
| `p` | Pull |

### 🧠 LSP (Language Server Protocol)

| Atalho | O que faz |
|--------|-----------|
| `gd` | **G**o to **d**efinition |
| `K` | Hover (documentação) |
| `Space + lf` | **F**ormat código |
| `Space + ln` | Re**n**ame símbolo |
| `Space + la` | Code **a**ctions |
| `Space + le` | Mostra **e**rro |
| `Space + lr` | Lista **r**eferences |
| `Space + li` | Lista **i**mplementations |
| `Space + lj` | Próximo diagnóstico |
| `Space + lk` | Diagnóstico anterior |

### 💬 Comentários

| Atalho | O que faz |
|--------|-----------|
| `gcc` | Comenta/descomenta linha |
| `gc` (visual) | Comenta seleção |
| `gcap` | Comenta parágrafo |

---

## 🦎 Conjure (REPL Clojure)

> O leader local do Conjure é `,` (vírgula)

### Avaliar código:

| Atalho | O que faz |
|--------|-----------|
| `,ee` | **E**val expressão sob cursor |
| `,er` | **E**val **r**oot form (defn, def...) |
| `,eb` | **E**val **b**uffer inteiro |
| `,ef` | **E**val **f**ile |
| `,ew` | **E**val **w**ord |
| `,e!` | Substitui form pelo resultado |

### Log do REPL:

| Atalho | O que faz |
|--------|-----------|
| `,ls` | **L**og **s**how |
| `,lv` | **L**og **v**ertical |
| `,lr` | **L**og **r**eset |
| `,lq` | **L**og **q**uit |

### Testes:

| Atalho | O que faz |
|--------|-----------|
| `,tt` | Roda **t**este sob cursor |
| `,tn` | Roda testes do **n**amespace |
| `,ta` | Roda **a**ll testes |

### Documentação:

| Atalho | O que faz |
|--------|-----------|
| `K` | Doc da função sob cursor |
| `,ds` | Doc **s**ource |

### Conexão:

| Comando | O que faz |
|---------|-----------|
| `:ConjureConnect` | Conecta ao REPL |
| `:ConjureConnect host:porta` | Conecta em endereço específico |

---

## 🖥️ iTerm2

### 📑 Janelas e Abas

| Atalho | O que faz |
|--------|-----------|
| `Cmd + N` | Nova janela |
| `Cmd + T` | Nova aba |
| `Cmd + W` | Fecha aba/painel |
| `Cmd + Q` | Fecha iTerm2 |

### ✂️ Dividir Tela (Split Panes)

| Atalho | O que faz |
|--------|-----------|
| `Cmd + D` | Split vertical (lado a lado) |
| `Cmd + Shift + D` | Split horizontal (empilhado) |

```
Cmd + D:                    Cmd + Shift + D:
┌─────────┬─────────┐      ┌─────────────────┐
│         │         │      │                 │
│    A    │    B    │      │        A        │
│         │         │      │                 │
└─────────┴─────────┘      ├─────────────────┤
                           │        B        │
                           └─────────────────┘
```

### 🧭 Navegar entre Painéis

| Atalho | Vai para |
|--------|----------|
| `Cmd + Option + ←` | Painel esquerda |
| `Cmd + Option + →` | Painel direita |
| `Cmd + Option + ↑` | Painel acima |
| `Cmd + Option + ↓` | Painel abaixo |
| `Cmd + ]` | Próximo painel |
| `Cmd + [` | Painel anterior |

### 📐 Redimensionar

| Atalho | O que faz |
|--------|-----------|
| `Cmd + Shift + Enter` | Maximiza/restaura painel |
| `Ctrl + Cmd + ←/→/↑/↓` | Redimensiona painel |

### 🔀 Navegação entre Abas

| Atalho | O que faz |
|--------|-----------|
| `Cmd + ←` | Aba anterior |
| `Cmd + →` | Próxima aba |
| `Cmd + 1-9` | Vai para aba específica |

### 🔧 Utilitários

| Atalho | O que faz |
|--------|-----------|
| `Cmd + ,` | Preferências |
| `Cmd + K` | Limpa terminal |
| `Cmd + F` | Busca no terminal |
| `Cmd + +` | Aumenta fonte |
| `Cmd + -` | Diminui fonte |
| `Cmd + 0` | Fonte padrão |

---

## ⌨️ Terminal & Shell

### 📂 Navegação

| Comando | O que faz |
|---------|-----------|
| `cd pasta` | Entra na pasta |
| `cd ..` | Volta uma pasta |
| `cd ~` | Vai para home |
| `cd -` | Volta para pasta anterior |
| `pwd` | Mostra pasta atual |
| `ls` | Lista arquivos |
| `ls -la` | Lista detalhado + ocultos |
| `tree` | Árvore de diretórios |

### 📄 Arquivos

| Comando | O que faz |
|---------|-----------|
| `touch arquivo` | Cria arquivo vazio |
| `mkdir pasta` | Cria pasta |
| `mkdir -p a/b/c` | Cria pastas aninhadas |
| `cp origem destino` | Copia |
| `mv origem destino` | Move/renomeia |
| `rm arquivo` | Remove arquivo |
| `rm -r pasta` | Remove pasta |
| `cat arquivo` | Mostra conteúdo |
| `less arquivo` | Mostra com scroll |
| `head -n 10 arquivo` | Primeiras 10 linhas |
| `tail -n 10 arquivo` | Últimas 10 linhas |
| `tail -f arquivo` | Segue arquivo (logs) |

### 🔍 Busca

| Comando | O que faz |
|---------|-----------|
| `find . -name "*.clj"` | Busca arquivos por nome |
| `grep "texto" arquivo` | Busca texto em arquivo |
| `grep -r "texto" .` | Busca recursiva |
| `rg "texto"` | Ripgrep (mais rápido) |
| `fzf` | Busca fuzzy interativa |

### ⚡ Atalhos do Zsh

| Atalho | O que faz |
|--------|-----------|
| `Ctrl + R` | Busca histórico |
| `Ctrl + A` | Início da linha |
| `Ctrl + E` | Fim da linha |
| `Ctrl + W` | Apaga palavra anterior |
| `Ctrl + U` | Apaga linha inteira |
| `Ctrl + L` | Limpa tela |
| `Ctrl + C` | Cancela comando |
| `Ctrl + Z` | Suspende processo |
| `!!` | Repete último comando |
| `!$` | Último argumento |
| `Tab` | Autocomplete |

### 🔧 Git (linha de comando)

| Comando | O que faz |
|---------|-----------|
| `git status` | Status atual |
| `git add .` | Stage tudo |
| `git add -p` | Stage interativo |
| `git commit -m "msg"` | Commit |
| `git push` | Envia para remote |
| `git pull` | Baixa do remote |
| `git log --oneline` | Histórico resumido |
| `git diff` | Mudanças não staged |
| `git diff --staged` | Mudanças staged |
| `git checkout -b branch` | Cria e muda branch |
| `git stash` | Guarda mudanças |
| `git stash pop` | Restaura mudanças |

### ☕ Clojure/Java

| Comando | O que faz |
|---------|-----------|
| `lein repl` | Inicia REPL (Leiningen) |
| `clj` | Inicia REPL (CLI) |
| `lein test` | Roda testes |
| `lein run` | Roda aplicação |
| `java -version` | Versão do Java |
| `java11` | Muda para Java 11 (alias) |
| `java23` | Muda para Java 23 (alias) |

---

## 🎯 Workflow Diário

### 🌅 Começando o dia:

```bash
# 1. Abra o terminal (iTerm2)

# 2. Vá para o projeto
cd ~/dev/projeto

# 3. Abra o Neovim
nvim

# 4. Divida a tela (Cmd + Shift + D no iTerm)
#    - Cima: Neovim
#    - Baixo: Terminal

# 5. No terminal de baixo, inicie o REPL
lein repl

# 6. Pronto! O Conjure conecta automaticamente 🎉
```

### 💻 Desenvolvendo:

```
1. Space + ff    → Abre arquivo
2. Edita código
3. ,er           → Avalia função no REPL
4. Space + lf    → Formata código
5. :w            → Salva
6. Space + gg    → LazyGit para commit
```

### 🧭 Navegando código:

```
gd              → Vai para definição
Ctrl + o        → Volta
K               → Documentação
Space + lr      → Onde é usado?
Space + fg      → Busca texto no projeto
```

### 🏠 Layout sugerido:

```
┌──────────────────────────────────────────┐
│                                          │
│              NEOVIM                       │
│         (código principal)               │
│                                          │
├────────────────────┬─────────────────────┤
│                    │                     │
│   REPL / logs      │   git / comandos    │
│                    │                     │
└────────────────────┴─────────────────────┘
```

Para criar:
1. `Cmd + Shift + D` (divide horizontal)
2. No painel de baixo: `Cmd + D` (divide vertical)

---

## 🎓 Dicas para Iniciantes

### 1. Comece devagar
Não tente decorar tudo. Aprenda 5 comandos por dia:
- Dia 1: `hjkl`, `i`, `Esc`, `:w`, `:q`
- Dia 2: `dd`, `yy`, `p`, `u`, `.`
- Dia 3: `w`, `b`, `0`, `$`, `gg`, `G`
- Dia 4: `/`, `n`, `N`, `*`
- Dia 5: `ciw`, `diw`, `yiw`

### 2. Use o ponto (`.`)
O `.` repete a última ação. É seu melhor amigo!

### 3. Pense em "verbos" e "objetos"
- `d` = deletar, `c` = mudar, `y` = copiar
- `w` = palavra, `$` = fim da linha, `iw` = inner word

### 4. Não tenha medo do `:help`
`:help w` mostra ajuda sobre o movimento `w`

### 5. Use este guia!
Deixe aberto em uma aba. Consulte sempre que precisar.

---

## 📚 Recursos

- **vimtutor** - Tutorial interativo (rode `vimtutor` no terminal)
- [Vim Adventures](https://vim-adventures.com/) - Jogo para aprender Vim
- [OpenVim](https://www.openvim.com/) - Tutorial interativo online
- [ThePrimeagen](https://www.youtube.com/@ThePrimeagen) - YouTube sobre Vim/Neovim

---

<div align="center">

**Feito com 💜 para a comunidade**

*"Vim não é um editor de texto. É uma linguagem para editar texto."*

</div>
