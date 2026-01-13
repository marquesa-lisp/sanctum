# 🖥️ Guia de Criação de VMs Ubuntu

Este guia ensina como criar uma máquina virtual (VM) com Ubuntu para usar o Sanctum.

## Índice

- [VM Ubuntu no macOS](#vm-ubuntu-no-macos)
- [VM Ubuntu no Windows](#vm-ubuntu-no-windows)
- [Após Instalar o Ubuntu](#após-instalar-o-ubuntu)
- [Checklist de Validação](#checklist-de-validação)

---

## VM Ubuntu no macOS

### Opção Recomendada: UTM (Gratuito)

O **UTM** é a melhor opção para Macs, especialmente com Apple Silicon (M1/M2/M3/M4).

#### 1. Instalar UTM

```bash
brew install --cask utm
```

Ou baixe diretamente: https://mac.getutm.app/

#### 2. Baixar Ubuntu

**Para Mac com Apple Silicon (M1/M2/M3/M4):**

👉 **Link direto (ARM64):** https://cdimage.ubuntu.com/noble/daily-live/current/noble-desktop-arm64.iso

> ⚠️ **Importante:** NÃO baixe a versão "amd64" - ela vai rodar emulada e será muito lenta!

**Para Mac Intel:**
- Baixe o Ubuntu Desktop **AMD64**: https://ubuntu.com/download/desktop
- Use a versão padrão (64-bit)

#### 3. Criar a VM no UTM

1. Abra o **UTM**
2. Clique em **"Create a New Virtual Machine"** ou **"+"**
3. Selecione **"Virtualize"** (mais rápido que Emulate)
4. Escolha **"Linux"**
5. Em **"Boot ISO Image"**, clique em **"Browse"** e selecione o ISO do Ubuntu baixado
6. Configure os recursos:

| Recurso | Recomendado | Mínimo |
|---------|-------------|--------|
| **RAM** | 4 GB | 2 GB |
| **CPU Cores** | 4 | 2 |
| **Disco** | 30 GB | 20 GB |

7. Clique em **"Save"** e depois **"Play"** para iniciar

#### 4. Instalar Ubuntu

1. Selecione **"Try or Install Ubuntu"**
2. Siga o assistente de instalação:
   - Idioma: Português (Brasil) ou English
   - Teclado: Portuguese (Brazil) - ABNT2 ou seu layout
   - Tipo de instalação: **"Erase disk and install Ubuntu"** (é seguro, é dentro da VM)
   - Crie seu usuário e senha
3. Aguarde a instalação e reinicie quando solicitado
4. **Importante:** Quando pedir para remover o disco de instalação, vá em UTM → CD/DVD → Clear para remover o ISO

#### 5. Dicas Úteis no UTM

**Criar Snapshot (salvar estado):**
- Menu: **VM** → **Snapshots** → **Take Snapshot**
- Útil antes de testar scripts, assim você pode voltar se algo der errado

**Compartilhar arquivos com o Mac:**
- Instale o SPICE Guest Tools no Ubuntu:
```bash
sudo apt install spice-vdagent spice-webdavd
```

**Copiar e colar entre Mac e VM:**
- Funciona automaticamente após instalar o spice-vdagent

---

## VM Ubuntu no Windows

### Opção 1: VirtualBox (Gratuito e Simples)

O **VirtualBox** é gratuito e funciona bem para a maioria dos casos.

#### 1. Instalar VirtualBox

1. Baixe em: https://www.virtualbox.org/wiki/Downloads
2. Clique em **"Windows hosts"**
3. Execute o instalador e siga as instruções (Next, Next, Install)
4. Reinicie o computador se solicitado

#### 2. Baixar Ubuntu

- Baixe o Ubuntu Desktop **64-bit**: https://ubuntu.com/download/desktop
- Escolha **Ubuntu 24.04.x LTS**

#### 3. Criar a VM no VirtualBox

1. Abra o **VirtualBox**
2. Clique em **"Novo"** (ou **"New"**)
3. Configure:
   - **Nome:** Ubuntu
   - **Pasta:** deixe o padrão
   - **ISO Image:** Selecione o Ubuntu baixado
   - Marque **"Skip Unattended Installation"** ✅
4. Clique em **"Próximo"**
5. Configure os recursos:

| Recurso | Recomendado | Mínimo |
|---------|-------------|--------|
| **RAM** | 4096 MB | 2048 MB |
| **CPU** | 2-4 | 1 |
| **Disco** | 30 GB | 20 GB |

6. Clique em **"Finalizar"**
7. Selecione a VM e clique em **"Iniciar"**

#### 4. Instalar Ubuntu

Siga os mesmos passos da [seção macOS](#4-instalar-ubuntu).

#### 5. Instalar Guest Additions (Importante!)

Após instalar o Ubuntu, instale as Guest Additions para melhor performance:

```bash
# No terminal do Ubuntu
sudo apt update
sudo apt install -y virtualbox-guest-utils virtualbox-guest-x11
sudo reboot
```

**Isso habilita:**
- Resolução de tela dinâmica
- Copiar e colar entre Windows e VM
- Pastas compartilhadas
- Melhor performance de vídeo

---

### Opção 2: VMware Workstation Player (Gratuito)

O **VMware** tem melhor performance que o VirtualBox em alguns casos.

#### 1. Instalar VMware

1. Baixe em: https://www.vmware.com/products/workstation-player.html
2. Escolha **"Download for Free"** (para uso pessoal)
3. Execute o instalador
4. Reinicie o computador

#### 2. Criar a VM

1. Abra o **VMware Workstation Player**
2. Clique em **"Create a New Virtual Machine"**
3. Selecione **"Installer disc image file (iso)"** e escolha o Ubuntu
4. Configure usuário e senha (ou pule para configurar durante instalação)
5. Configure os recursos:

| Recurso | Recomendado |
|---------|-------------|
| **Disco** | 30 GB |
| **RAM** | 4 GB |
| **CPU** | 2-4 cores |

6. Finalize e inicie a VM

#### 3. Instalar VMware Tools

Após instalar o Ubuntu:

```bash
sudo apt update
sudo apt install -y open-vm-tools open-vm-tools-desktop
sudo reboot
```

---

### Opção 3: WSL2 + Interface Gráfica (Alternativa Leve)

Se você quer algo mais leve que uma VM completa, pode usar WSL2 com interface gráfica.

#### 1. Instalar WSL2

```powershell
# No PowerShell como Administrador
wsl --install -d Ubuntu-24.04
```

#### 2. Configurar GUI (WSLg)

O Windows 11 já vem com WSLg que permite rodar apps gráficos. O Ghostty pode funcionar via WSLg:

```bash
# No terminal WSL
sudo apt update
sudo apt install -y x11-apps

# Testar se GUI funciona
xclock
```

> **Nota:** WSL2 é mais limitado que uma VM completa. Algumas funcionalidades do Ghostty podem não funcionar perfeitamente.

---

## Após Instalar o Ubuntu

Independente de estar no Mac ou Windows, execute estes comandos no Ubuntu:

### 1. Atualizar o Sistema

```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Instalar Git

```bash
sudo apt install -y git curl
```

### 3. Clonar e Instalar o Sanctum

```bash
# Clonar o repositório
git clone https://github.com/marquesa-lisp/sanctum.git ~/dev/github/sanctum

# Entrar no diretório
cd ~/dev/github/sanctum

# Executar o instalador
./install-ubuntu.sh
```

### 4. Reiniciar o Terminal

Feche e abra o terminal novamente, ou execute:

```bash
source ~/.zshrc
```

### 5. Verificar Instalação

```bash
./scripts/doctor-ubuntu.sh
```

---

## Checklist de Validação

Após instalar o Sanctum, verifique se tudo funciona:

### Terminal (Ghostty)

- [ ] Ghostty abre corretamente
- [ ] Fonte JetBrainsMono Nerd Font está funcionando (ícones aparecem)
- [ ] Tema Tairiki aplicado (cores corretas)
- [ ] Criar nova tab: `Ctrl+F` depois `C`
- [ ] Criar split horizontal: `Ctrl+F` depois `J`
- [ ] Criar split vertical: `Ctrl+F` depois `L`
- [ ] Navegar entre splits: `Ctrl+W` depois `H/J/K/L`

### Shell (Zsh + Powerlevel10k)

- [ ] Prompt do Powerlevel10k aparece bonito
- [ ] Ícones do prompt funcionam (git, etc.)
- [ ] Autosuggestions funciona (texto cinza ao digitar)
- [ ] Syntax highlighting funciona (comandos coloridos)

### Editor (Neovim)

- [ ] `nvim` abre sem erros
- [ ] Plugins carregam automaticamente
- [ ] `Space + e` abre o file explorer (nvim-tree)
- [ ] `Space + f + f` abre o Telescope (busca de arquivos)

### Linguagens

- [ ] `java --version` → mostra Java 21
- [ ] `clojure --version` → mostra Clojure CLI
- [ ] `clojure-lsp --version` → mostra clojure-lsp
- [ ] `node --version` → mostra Node.js (se instalado)

### Ferramentas

- [ ] `git --version` → Git instalado
- [ ] `lazygit` → abre interface do Git
- [ ] `rg --version` → ripgrep instalado
- [ ] `fzf --version` → fzf instalado

---

## Solução de Problemas

### Ghostty não abre

```bash
# Verificar se está instalado
which ghostty

# Se não estiver, reinstalar
cd ~/dev/github/sanctum
./install-ubuntu.sh
```

### Fontes não aparecem corretamente

```bash
# Reinstalar fontes
cd /tmp
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -fv
```

### Powerlevel10k não aparece

```bash
# Reconfigurar
p10k configure
```

### Plugins do Neovim não carregam

```bash
# Abrir nvim e rodar
:Lazy sync
```

---

## Recursos Úteis

- [UTM Documentation](https://docs.getutm.app/)
- [VirtualBox Manual](https://www.virtualbox.org/manual/)
- [VMware Documentation](https://docs.vmware.com/)
- [Ubuntu Desktop Guide](https://help.ubuntu.com/stable/ubuntu-help/)
- [Ghostty Documentation](https://ghostty.org/docs)
