# 🗺️ Keymaps Ubuntu - Guia de Sobrevivência

> *"No Linux, você não clica em botões. Você **compõe comandos** no terminal."*

Este guia foi feito para quem está começando no Ubuntu com Alacritty + tmux + Neovim.
Não precisa decorar tudo — use como referência no dia a dia! 📚

---

## 📖 Índice

1. [🖥️ Alacritty (Terminal)](#️-alacritty-terminal)
2. [🪟 tmux (Multiplexador)](#-tmux-multiplexador)
3. [⌨️ Terminal & Shell (Zsh)](#️-terminal--shell-zsh)
4. [🔄 Comparação com macOS/iTerm2](#-comparação-com-macositerm2)
5. [🎯 Workflow Diário Ubuntu](#-workflow-diário-ubuntu)
6. [🎓 Dicas para Iniciantes](#-dicas-para-iniciantes)

---

## 🖥️ Alacritty (Terminal)

O Alacritty é um terminal minimalista e rápido. Ele é a "janela" onde você trabalha.

### Atalhos básicos:

| Atalho | O que faz |
|--------|-----------|
| `Ctrl + Shift + C` | Copiar texto selecionado |
| `Ctrl + Shift + V` | Colar |
| `Ctrl + 0` | Resetar tamanho da fonte |
| `Ctrl + +` | Aumentar fonte |
| `Ctrl + -` | Diminuir fonte |
| `Ctrl + L` | Limpar tela |

### Seleção de texto:

| Ação | Como fazer |
|------|------------|
| Selecionar texto | Clique e arraste com mouse |
| Selecionar palavra | Duplo clique |
| Selecionar linha | Triplo clique |
| Colar seleção | Clique do meio do mouse |

> 💡 **Nota:** O Alacritty não tem tabs ou splits nativos. Para isso, usamos o **tmux**!

---

## 🪟 tmux (Multiplexador)

O tmux permite dividir a tela, criar abas e manter sessões persistentes.

### 🔑 O Prefixo

Todos os comandos do tmux começam com um **prefixo**. 
Na config do Sanctum, o prefixo é **`Ctrl + A`** (mais fácil que o padrão `Ctrl + B`).

```
Prefixo = Ctrl + A

Para executar um comando:
1. Pressione Ctrl + A
2. Solte
3. Pressione a tecla do comando
```

### ✂️ Dividir Tela (Splits)

| Atalho | O que faz | Visual |
|--------|-----------|--------|
| `Ctrl+A` depois `\|` | Split vertical | lado a lado |
| `Ctrl+A` depois `\` | Split vertical | (alternativo) |
| `Ctrl+A` depois `-` | Split horizontal | um em cima do outro |

```
Ctrl+A |                    Ctrl+A -
┌─────────┬─────────┐      ┌─────────────────┐
│         │         │      │                 │
│ painel  │ painel  │      │    painel A     │
│    A    │    B    │      │                 │
│         │         │      ├─────────────────┤
└─────────┴─────────┘      │    painel B     │
                           └─────────────────┘
```

### 🧭 Navegar entre Painéis

| Atalho | Vai para |
|--------|----------|
| `Alt + ←` | Painel à esquerda |
| `Alt + →` | Painel à direita |
| `Alt + ↑` | Painel acima |
| `Alt + ↓` | Painel abaixo |

**Com prefixo (alternativo):**

| Atalho | Vai para |
|--------|----------|
| `Ctrl+A` depois `h` | Painel à esquerda |
| `Ctrl+A` depois `l` | Painel à direita |
| `Ctrl+A` depois `k` | Painel acima |
| `Ctrl+A` depois `j` | Painel abaixo |

> 💡 **Dica:** `Alt + setas` é mais rápido pois não precisa do prefixo!

### 📐 Redimensionar Painéis

| Atalho | O que faz |
|--------|-----------|
| `Ctrl + ←` | Diminui largura |
| `Ctrl + →` | Aumenta largura |
| `Ctrl + ↑` | Diminui altura |
| `Ctrl + ↓` | Aumenta altura |

### ❌ Fechar Painéis

| Atalho | O que faz |
|--------|-----------|
| `Ctrl+A` depois `x` | Fecha painel atual (pede confirmação) |
| `exit` ou `Ctrl+D` | Fecha painel (sem confirmação) |

### 📑 Janelas (Tabs)

| Atalho | O que faz |
|--------|-----------|
| `Ctrl+A` depois `c` | **C**ria nova janela |
| `Ctrl+A` depois `n` | **N**ext - próxima janela |
| `Ctrl+A` depois `p` | **P**revious - janela anterior |
| `Ctrl+A` depois `0-9` | Vai para janela específica |
| `Ctrl+A` depois `,` | Renomeia janela atual |
| `Ctrl+A` depois `&` | Fecha janela (pede confirmação) |

### 💾 Sessões (persistência)

O tmux mantém suas sessões mesmo se você fechar o terminal!

| Comando/Atalho | O que faz |
|----------------|-----------|
| `tmux` | Inicia nova sessão |
| `tmux new -s nome` | Nova sessão com nome |
| `Ctrl+A` depois `d` | **D**esconecta (sessão continua!) |
| `tmux attach` ou `tmux a` | Reconecta à sessão |
| `tmux ls` | Lista sessões |
| `tmux kill-session -t nome` | Mata sessão |

```
Exemplo de uso:

$ tmux new -s projeto    # Cria sessão "projeto"
# trabalha...
Ctrl+A d                  # Desconecta

# Fecha o terminal, vai embora, volta depois...

$ tmux attach -t projeto  # Reconecta! Tudo ainda está lá! 🎉
```

### 🔧 Outros comandos úteis

| Atalho | O que faz |
|--------|-----------|
| `Ctrl+A` depois `r` | **R**ecarrega config do tmux |
| `Ctrl+A` depois `z` | **Z**oom - maximiza/restaura painel |
| `Ctrl+A` depois `[` | Modo scroll (use setas, `q` para sair) |
| `Ctrl+A` depois `?` | Lista todos os atalhos |

### 🎨 Status bar

A barra inferior mostra:
- Nome da sessão (esquerda)
- Janelas abertas (centro)
- Hora e hostname (direita)

```
┌────────────────────────────────────────────────────────┐
│                      CONTEÚDO                          │
│                                                        │
├────────────────────────────────────────────────────────┤
│ session │ 1:nvim* 2:shell 3:git │           12:34 host│
└────────────────────────────────────────────────────────┘
```

---

## ⌨️ Terminal & Shell (Zsh)

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

### ⚡ Atalhos do Zsh

| Atalho | O que faz |
|--------|-----------|
| `Ctrl + R` | Busca no histórico |
| `Ctrl + A` | Início da linha |
| `Ctrl + E` | Fim da linha |
| `Ctrl + W` | Apaga palavra anterior |
| `Ctrl + U` | Apaga do cursor até início |
| `Ctrl + K` | Apaga do cursor até fim |
| `Ctrl + L` | Limpa tela |
| `Ctrl + C` | Cancela comando |
| `Ctrl + D` | Fecha terminal/sai |
| `Tab` | Autocomplete |
| `Tab Tab` | Lista opções de autocomplete |
| `↑` / `↓` | Navega histórico |
| `!!` | Repete último comando |
| `!$` | Último argumento do comando anterior |

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

### 🔍 Busca

| Comando | O que faz |
|---------|-----------|
| `find . -name "*.clj"` | Busca arquivos por nome |
| `grep "texto" arquivo` | Busca texto em arquivo |
| `grep -r "texto" .` | Busca recursiva |
| `rg "texto"` | Ripgrep (mais rápido) |
| `fzf` | Busca fuzzy interativa |

### 🔧 Git

| Comando | O que faz |
|---------|-----------|
| `git status` | Status atual |
| `git add .` | Stage tudo |
| `git commit -m "msg"` | Commit |
| `git push` | Envia para remote |
| `git pull` | Baixa do remote |
| `git log --oneline` | Histórico resumido |
| `git diff` | Mudanças não staged |
| `lg` | LazyGit (alias) |

### ☕ Java & Clojure

| Comando | O que faz |
|---------|-----------|
| `java --version` | Versão do Java |
| `java11` | Muda para Java 11 (alias) |
| `java17` | Muda para Java 17 (alias) |
| `java21` | Muda para Java 21 (alias) |
| `clojure` ou `clj` | Inicia REPL |
| `clojure-lsp --version` | Versão do LSP |

---

## 🔄 Comparação com macOS/iTerm2

Se você vem do Mac, aqui está a tradução:

### Teclas modificadoras

| Mac | Linux |
|-----|-------|
| `Command (⌘)` | `Ctrl` (maioria) ou `Super` |
| `Option (⌥)` | `Alt` |
| `Control (⌃)` | `Ctrl` |

### Terminal - Copiar/Colar

| iTerm2 (Mac) | Alacritty (Linux) |
|--------------|-------------------|
| `Cmd + C` | `Ctrl + Shift + C` |
| `Cmd + V` | `Ctrl + Shift + V` |
| `Cmd + K` | `Ctrl + L` |

### Terminal - Splits

| iTerm2 (Mac) | tmux (Linux) |
|--------------|--------------|
| `Cmd + D` | `Ctrl+A` depois `\|` |
| `Cmd + Shift + D` | `Ctrl+A` depois `-` |
| `Cmd + Option + setas` | `Alt + setas` |
| `Cmd + W` | `Ctrl+A` depois `x` |

### Terminal - Tabs

| iTerm2 (Mac) | tmux (Linux) |
|--------------|--------------|
| `Cmd + T` | `Ctrl+A` depois `c` |
| `Cmd + W` | `Ctrl+A` depois `&` |
| `Cmd + 1-9` | `Ctrl+A` depois `1-9` |
| `Cmd + ←/→` | `Ctrl+A` depois `n/p` |

### Tabela resumida

| Ação | Mac (iTerm2) | Linux (tmux) |
|------|--------------|--------------|
| Split vertical | `Cmd + D` | `Ctrl+A \|` |
| Split horizontal | `Cmd + Shift + D` | `Ctrl+A -` |
| Navegar painéis | `Cmd + Option + setas` | `Alt + setas` |
| Nova aba | `Cmd + T` | `Ctrl+A c` |
| Fechar painel | `Cmd + W` | `Ctrl+A x` |
| Copiar | `Cmd + C` | `Ctrl + Shift + C` |
| Colar | `Cmd + V` | `Ctrl + Shift + V` |
| Limpar | `Cmd + K` | `Ctrl + L` |

---

## 🎯 Workflow Diário Ubuntu

### 🌅 Começando o dia

```bash
# 1. Abra o Alacritty (pelo menu ou terminal padrão)
alacritty

# 2. Inicie o tmux
tmux

# 3. Vá para o projeto
cd ~/dev/projeto

# 4. Crie seus painéis
# Ctrl+A | → divide vertical
# Ctrl+A - → divide horizontal

# 5. No painel principal, abra o Neovim
nvim

# 6. No outro painel, inicie o REPL (se usar Clojure)
clj
```

### 🏠 Layout sugerido

```
┌──────────────────────────────────────────────────────┐
│                                                      │
│                     NEOVIM                           │
│                (código principal)                    │
│                                                      │
├────────────────────────┬─────────────────────────────┤
│                        │                             │
│   REPL / testes        │   git / comandos            │
│                        │                             │
└────────────────────────┴─────────────────────────────┘
```

**Para criar esse layout:**
1. `tmux` - inicia
2. `Ctrl+A -` - divide horizontal
3. No painel de baixo: `Ctrl+A |` - divide vertical
4. `Alt + ↑` - volta pro painel de cima
5. `nvim` - abre o editor

### 💻 Desenvolvendo

```
1. Space + ff    → Abre arquivo (Telescope)
2. Edita código
3. ,er           → Avalia função no REPL (Conjure)
4. Space + lf    → Formata código
5. :w            → Salva
6. Alt + ↓       → Vai pro painel de baixo
7. lg            → LazyGit para commit
8. Alt + ↑       → Volta pro código
```

### 📌 Dica de ouro: Sessões

```bash
# No fim do dia, não feche tudo! Apenas desconecte:
Ctrl+A d

# Amanhã, reconecte e tudo estará exatamente como você deixou:
tmux attach
```

---

## 🎓 Dicas para Iniciantes

### 1. Memorize o prefixo
O prefixo é `Ctrl+A`. Isso abre as "portas" do tmux.

### 2. Comece com poucos comandos
- `Ctrl+A |` - split
- `Alt + setas` - navegar
- `Ctrl+A x` - fechar
- `Ctrl+A d` - desconectar

### 3. Use `Alt + setas` sempre que possível
Não precisa do prefixo! É mais rápido.

### 4. Lembre: `Ctrl + Shift` para copiar/colar
Diferente do Mac, no Linux é `Ctrl + Shift + C/V`.

### 5. Aprenda tmux antes de personalizar
Use a config do Sanctum por um tempo antes de modificar.

### 6. Mantenha este guia aberto
Deixe em uma aba do navegador. Consulte sempre!

---

## 📋 Cheatsheet Rápido

### tmux (prefixo = Ctrl+A)

```
SPLITS:
  Ctrl+A |     Split vertical
  Ctrl+A -     Split horizontal
  
NAVEGAR:
  Alt + setas  Mover entre painéis (sem prefixo!)
  
PAINÉIS:
  Ctrl+A x     Fechar painel
  Ctrl+A z     Zoom (maximiza/restaura)
  
JANELAS:
  Ctrl+A c     Nova janela
  Ctrl+A n/p   Próxima/anterior
  Ctrl+A 0-9   Ir para janela
  
SESSÃO:
  Ctrl+A d     Desconectar
  tmux a       Reconectar
```

### Alacritty + Zsh

```
COPIAR/COLAR:
  Ctrl+Shift+C   Copiar
  Ctrl+Shift+V   Colar
  
TERMINAL:
  Ctrl+L         Limpar tela
  Ctrl+R         Buscar histórico
  Ctrl+C         Cancelar
  Tab            Autocomplete
```

---

<div align="center">

**Feito com 💜 para quem está migrando do Mac para o Linux**

*"O terminal é seu amigo. Com o tempo, você vai preferir ele."*

</div>
