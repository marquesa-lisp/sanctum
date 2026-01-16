# 🪟 Guia de Instalação WSL2 + Alacritty (Windows)

Este guia ensina como configurar o Sanctum no Windows usando WSL2 + Alacritty.

> 💡 **Recomendado para:** Computadores com pouca RAM (4-8 GB) ou processadores mais fracos (Celeron, Pentium).

## Índice

- [Pré-requisitos](#pré-requisitos)
- [Passo 1: Instalar WSL2](#passo-1-instalar-wsl2)
- [Passo 2: Instalar Sanctum no WSL2](#passo-2-instalar-sanctum-no-wsl2)
- [Passo 3: Instalar Alacritty no Windows](#passo-3-instalar-alacritty-no-windows)
- [Passo 4: Instalar Fontes no Windows](#passo-4-instalar-fontes-no-windows)
- [Passo 5: Configurar Alacritty](#passo-5-configurar-alacritty)
- [Usando o Ambiente](#usando-o-ambiente)
- [Atalhos Importantes](#atalhos-importantes)
- [Solução de Problemas](#solução-de-problemas)

---

## Pré-requisitos

| Requisito | Mínimo |
|-----------|--------|
| **Windows** | Windows 10 versão 2004+ ou Windows 11 |
| **RAM** | 4 GB (8 GB recomendado) |
| **Disco** | 10 GB livres |

---

## Passo 1: Instalar WSL2

### 1.1 Abrir PowerShell como Administrador

1. Pressione `Win + X`
2. Clique em **"Terminal (Admin)"** ou **"PowerShell (Admin)"**

### 1.2 Instalar WSL2 com Ubuntu

```powershell
wsl --install -d Ubuntu-24.04
```

Aguarde a instalação. O computador pode precisar reiniciar.

### 1.3 Configurar usuário

Após reiniciar, o Ubuntu vai abrir automaticamente pedindo:
- **Nome de usuário:** escolha um (ex: `daniel`)
- **Senha:** escolha uma senha (vai precisar dela!)

### 1.4 Verificar instalação

```powershell
wsl --list --verbose
```

Deve mostrar:
```
  NAME            STATE           VERSION
* Ubuntu-24.04    Running         2
```

---

## Passo 2: Instalar Sanctum no WSL2

### 2.1 Abrir o Ubuntu

- Pelo menu iniciar: procure por **"Ubuntu"**
- Ou no PowerShell: `wsl`

### 2.2 Instalar git

```bash
sudo apt update && sudo apt install -y git curl
```

### 2.3 Clonar e instalar Sanctum

```bash
git clone https://github.com/marquesa-lisp/sanctum.git ~/dev/github/sanctum
cd ~/dev/github/sanctum
chmod +x install-windows.sh
./install-windows.sh
```

Aguarde a instalação (pode demorar 5-10 minutos).

### 2.4 Verificar instalação

```bash
./scripts/doctor-windows.sh
```

---

## Passo 3: Instalar Alacritty no Windows

### 3.1 Usando Winget (recomendado)

Abra o **PowerShell** (não o Ubuntu!) e execute:

```powershell
winget install Alacritty.Alacritty
```

### 3.2 Ou download manual

1. Acesse: https://github.com/alacritty/alacritty/releases
2. Baixe o arquivo `.msi` para Windows
3. Execute o instalador

---

## Passo 4: Instalar Fontes no Windows

O Alacritty precisa das fontes instaladas no **Windows**, não no WSL2.

### 4.1 Baixar JetBrains Mono Nerd Font

1. Acesse: https://github.com/ryanoasis/nerd-fonts/releases
2. Baixe: **JetBrainsMono.zip**
3. Extraia o ZIP
4. Selecione todos os arquivos `.ttf`
5. Clique com botão direito → **"Instalar para todos os usuários"**

---

## Passo 5: Configurar Alacritty

### 5.1 Criar pasta de configuração

Abra o **PowerShell** e execute:

```powershell
mkdir "$env:APPDATA\alacritty" -Force
notepad "$env:APPDATA\alacritty\alacritty.toml"
```

### 5.2 Colar a configuração

Cole o seguinte conteúdo no Notepad e salve:

```toml
# ╔═══════════════════════════════════════════════════════════════════╗
# ║   Alacritty Config - Windows + WSL2                               ║
# ╚═══════════════════════════════════════════════════════════════════╝

# Shell - Abre WSL2 automaticamente
[shell]
program = "wsl.exe"
args = ["--cd", "~"]

# Janela
[window]
decorations = "Full"
opacity = 0.95
startup_mode = "Maximized"
title = "Alacritty - WSL2"
dynamic_title = true

[window.padding]
x = 10
y = 10

# Fonte
[font]
size = 12.0

[font.normal]
family = "JetBrainsMono Nerd Font"
style = "Regular"

[font.bold]
family = "JetBrainsMono Nerd Font"
style = "Bold"

[font.italic]
family = "JetBrainsMono Nerd Font"
style = "Italic"

# Cursor
[cursor]
blink_interval = 500
unfocused_hollow = true

[cursor.style]
shape = "Block"
blinking = "On"

# Scrolling
[scrolling]
history = 10000
multiplier = 3

# Tema - Catppuccin Mocha
[colors.primary]
background = "#1e1e2e"
foreground = "#cdd6f4"
dim_foreground = "#7f849c"
bright_foreground = "#cdd6f4"

[colors.cursor]
text = "#1e1e2e"
cursor = "#f5e0dc"

[colors.vi_mode_cursor]
text = "#1e1e2e"
cursor = "#b4befe"

[colors.search.matches]
foreground = "#1e1e2e"
background = "#a6adc8"

[colors.search.focused_match]
foreground = "#1e1e2e"
background = "#a6e3a1"

[colors.footer_bar]
foreground = "#1e1e2e"
background = "#a6adc8"

[colors.hints.start]
foreground = "#1e1e2e"
background = "#f9e2af"

[colors.hints.end]
foreground = "#1e1e2e"
background = "#a6adc8"

[colors.selection]
text = "#1e1e2e"
background = "#f5e0dc"

[colors.normal]
black = "#45475a"
red = "#f38ba8"
green = "#a6e3a1"
yellow = "#f9e2af"
blue = "#89b4fa"
magenta = "#f5c2e7"
cyan = "#94e2d5"
white = "#bac2de"

[colors.bright]
black = "#585b70"
red = "#f38ba8"
green = "#a6e3a1"
yellow = "#f9e2af"
blue = "#89b4fa"
magenta = "#f5c2e7"
cyan = "#94e2d5"
white = "#a6adc8"

[colors.dim]
black = "#45475a"
red = "#f38ba8"
green = "#a6e3a1"
yellow = "#f9e2af"
blue = "#89b4fa"
magenta = "#f5c2e7"
cyan = "#94e2d5"
white = "#bac2de"

# Keybindings
[[keyboard.bindings]]
key = "V"
mods = "Control|Shift"
action = "Paste"

[[keyboard.bindings]]
key = "C"
mods = "Control|Shift"
action = "Copy"

[[keyboard.bindings]]
key = "N"
mods = "Control|Shift"
action = "SpawnNewInstance"

[[keyboard.bindings]]
key = "Plus"
mods = "Control"
action = "IncreaseFontSize"

[[keyboard.bindings]]
key = "Minus"
mods = "Control"
action = "DecreaseFontSize"

[[keyboard.bindings]]
key = "Key0"
mods = "Control"
action = "ResetFontSize"
```

### 5.3 Testar

Feche o Notepad, depois abra o **Alacritty** pelo menu iniciar.

Deve abrir direto no Ubuntu com o prompt do Powerlevel10k!

---

## Usando o Ambiente

### Abrir o terminal

1. Clique no ícone do **Alacritty** no menu iniciar
2. Ou crie um atalho na área de trabalho

### Iniciar tmux (recomendado)

Sempre que abrir o terminal:

```bash
tmux
```

Isso habilita splits e múltiplas janelas.

### Workflow típico

```bash
# 1. Abrir Alacritty
# 2. Iniciar tmux
tmux

# 3. Dividir tela verticalmente
Ctrl+A |

# 4. No painel esquerdo: abrir Neovim
nvim meu-arquivo.clj

# 5. No painel direito: iniciar REPL
Ctrl+A → (navegar para direita)
lein repl
```

---

## Atalhos Importantes

### tmux (gerenciador de painéis)

| Atalho | O que faz |
|--------|-----------|
| `Ctrl+A |` | Split vertical |
| `Ctrl+A -` | Split horizontal |
| `Ctrl+A c` | Nova janela/aba |
| `Ctrl+A n` | Próxima janela |
| `Ctrl+A p` | Janela anterior |
| `Alt + setas` | Navegar entre painéis |
| `Ctrl+A d` | Desanexar (voltar depois com `tmux attach`) |
| `Ctrl+A x` | Fechar painel atual |

### Neovim

| Atalho | O que faz |
|--------|-----------|
| `Space + n` | Abrir/fechar árvore de arquivos |
| `Space + f + f` | Buscar arquivos |
| `Space + f + g` | Buscar texto no projeto |
| `gd` | Ir para definição |
| `K` | Ver documentação |
| `Space + rj` | Rodar Java Main |

### Clojure (Conjure)

| Atalho | O que faz |
|--------|-----------|
| `,er` | Avaliar função |
| `,ee` | Avaliar expressão |
| `,eb` | Avaliar buffer |
| `,ls` | Abrir log do REPL |

### Alacritty (Windows)

| Atalho | O que faz |
|--------|-----------|
| `Ctrl+Shift+C` | Copiar |
| `Ctrl+Shift+V` | Colar |
| `Ctrl+Shift+N` | Nova janela |
| `Ctrl++` | Aumentar fonte |
| `Ctrl+-` | Diminuir fonte |

---

## Solução de Problemas

### WSL2 não instala

```powershell
# Habilitar recursos necessários
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Reiniciar e tentar novamente
wsl --install -d Ubuntu-24.04
```

### Alacritty não abre WSL

Verifique se o arquivo de config está correto:
```powershell
notepad "$env:APPDATA\alacritty\alacritty.toml"
```

A seção `[shell]` deve ter:
```toml
[shell]
program = "wsl.exe"
args = ["--cd", "~"]
```

### Fonte não aparece corretamente

1. Verifique se a fonte está instalada no **Windows** (não no WSL)
2. Abra o Painel de Controle → Fontes
3. Procure por "JetBrainsMono Nerd Font"
4. Se não estiver, reinstale a fonte

### Powerlevel10k com símbolos estranhos

Execute dentro do WSL:
```bash
p10k configure
```

E escolha as opções que mostram os símbolos corretamente.

### tmux não funciona

Verifique se está instalado:
```bash
which tmux
# Se não estiver: sudo apt install tmux
```

### Neovim com erros de plugin

```bash
# Limpar cache
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Abrir nvim novamente
nvim
# Plugins serão reinstalados
```

---

## Recursos Úteis

- [WSL Documentation](https://docs.microsoft.com/en-us/windows/wsl/)
- [Alacritty Configuration](https://alacritty.org/config-alacritty.html)
- [tmux Cheat Sheet](https://tmuxcheatsheet.com/)
- [Neovim Documentation](https://neovim.io/doc/)
