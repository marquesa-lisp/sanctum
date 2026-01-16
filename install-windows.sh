#!/bin/bash

# ╔═══════════════════════════════════════════════════════════════════╗
# ║                                                                     ║
# ║   ███████╗ █████╗ ███╗   ██╗ ██████╗████████╗██╗   ██╗███╗   ███╗  ║
# ║   ██╔════╝██╔══██╗████╗  ██║██╔════╝╚══██╔══╝██║   ██║████╗ ████║  ║
# ║   ███████╗███████║██╔██╗ ██║██║        ██║   ██║   ██║██╔████╔██║  ║
# ║   ╚════██║██╔══██║██║╚██╗██║██║        ██║   ██║   ██║██║╚██╔╝██║  ║
# ║   ███████║██║  ██║██║ ╚████║╚██████╗   ██║   ╚██████╔╝██║ ╚═╝ ██║  ║
# ║   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝  ║
# ║                                                                     ║
# ║              Installation Script (Windows WSL2)                     ║
# ╚═══════════════════════════════════════════════════════════════════╝
#
# Este script deve ser executado DENTRO do WSL2 Ubuntu.
# Para instalar o Alacritty no Windows, siga as instruções no final.

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variáveis
SANCTUM_DIR="$HOME/dev/github/sanctum"
REPO_URL="https://github.com/marquesa-lisp/sanctum.git"

# Funções de output
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

step() {
    echo -e "\n${PURPLE}══════════════════════════════════════════════════════════════${NC}"
    echo -e "${PURPLE}  $1${NC}"
    echo -e "${PURPLE}══════════════════════════════════════════════════════════════${NC}\n"
}

# ============================================
# Verificações iniciais
# ============================================

# Verificar se está no WSL
if ! grep -qi microsoft /proc/version 2>/dev/null; then
    warn "Este script é otimizado para WSL2. Parece que você não está no WSL."
    warn "Se estiver em um Ubuntu normal, use ./install-ubuntu.sh"
    read -p "Deseja continuar mesmo assim? (s/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        exit 1
    fi
fi

# Verificar se está no Ubuntu/Debian
if ! command -v apt &> /dev/null; then
    error "Este script é para Ubuntu/Debian no WSL2."
fi

# Detectar versão do Ubuntu
if [ -f /etc/os-release ]; then
    . /etc/os-release
    info "Detectado: $NAME $VERSION_ID (WSL2)"
else
    info "Detectado: Sistema baseado em Debian (WSL2)"
fi

# ============================================
# Passo 1: Atualizar sistema e instalar dependências base
# ============================================
step "1/9 • Atualizando sistema e instalando dependências"

info "Atualizando lista de pacotes..."
sudo apt update

info "Instalando dependências base..."
sudo apt install -y \
    git \
    curl \
    wget \
    unzip \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    fontconfig

success "Dependências base instaladas"

# ============================================
# Passo 2: Clonar repositório
# ============================================
step "2/9 • Clonar Sanctum"

if [[ -d "$SANCTUM_DIR" ]]; then
    warn "Diretório $SANCTUM_DIR já existe"
    info "Atualizando repositório..."
    cd "$SANCTUM_DIR"
    git pull origin main || warn "Não foi possível atualizar (pode estar em branch diferente)"
else
    info "Clonando repositório..."
    mkdir -p "$(dirname "$SANCTUM_DIR")"
    git clone "$REPO_URL" "$SANCTUM_DIR"
    success "Repositório clonado em $SANCTUM_DIR"
fi

cd "$SANCTUM_DIR"

# ============================================
# Passo 3: Instalar Zsh
# ============================================
step "3/9 • Instalando Zsh"

if command -v zsh &> /dev/null; then
    success "Zsh já instalado: $(zsh --version)"
else
    info "Instalando Zsh..."
    sudo apt install -y zsh
    success "Zsh instalado"
fi

# ============================================
# Passo 4: Oh My Zsh + Plugins
# ============================================
step "4/9 • Oh My Zsh + Plugins"

if [[ -d "$HOME/.oh-my-zsh" ]]; then
    success "Oh My Zsh já instalado"
else
    info "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    success "Oh My Zsh instalado"
fi

# Powerlevel10k
if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    success "Powerlevel10k já instalado"
else
    info "Instalando Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    success "Powerlevel10k instalado"
fi

# zsh-autosuggestions
if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
    success "zsh-autosuggestions já instalado"
else
    info "Instalando zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    success "zsh-autosuggestions instalado"
fi

# zsh-syntax-highlighting
if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
    success "zsh-syntax-highlighting já instalado"
else
    info "Instalando zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    success "zsh-syntax-highlighting instalado"
fi

# ============================================
# Passo 5: Neovim + Ferramentas de Dev
# ============================================
step "5/9 • Neovim + Ferramentas de Dev"

# Neovim (versão estável mais recente via PPA)
if command -v nvim &> /dev/null; then
    success "Neovim já instalado: $(nvim --version | head -1)"
else
    info "Instalando Neovim..."
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt update
    sudo apt install -y neovim
    success "Neovim instalado"
fi

# ripgrep
if command -v rg &> /dev/null; then
    success "ripgrep já instalado"
else
    info "Instalando ripgrep..."
    sudo apt install -y ripgrep
    success "ripgrep instalado"
fi

# fzf
if command -v fzf &> /dev/null; then
    success "fzf já instalado"
else
    info "Instalando fzf..."
    sudo apt install -y fzf
    success "fzf instalado"
fi

# lazygit
if command -v lazygit &> /dev/null; then
    success "lazygit já instalado"
else
    info "Instalando lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm -f lazygit lazygit.tar.gz
    success "lazygit instalado"
fi

# Node.js (necessário para Copilot e outras ferramentas)
if command -v node &> /dev/null; then
    success "Node.js já instalado: $(node --version)"
else
    info "Instalando Node.js (LTS)..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
    success "Node.js instalado: $(node --version)"
fi

# htop, jq, rlwrap
info "Instalando utilitários extras..."
sudo apt install -y htop jq rlwrap neofetch cowsay fortune-mod sl
success "Utilitários instalados"

# ============================================
# Passo 6: Java
# ============================================
step "6/9 • Java (OpenJDK)"

if command -v java &> /dev/null; then
    success "Java já instalado: $(java -version 2>&1 | head -1)"
else
    info "Instalando OpenJDK..."
fi

# Instalar múltiplas versões do Java
sudo apt install -y openjdk-11-jdk openjdk-17-jdk openjdk-21-jdk

success "OpenJDK 11, 17 e 21 instalados"

# ============================================
# Passo 7: Clojure
# ============================================
step "7/9 • Clojure"

if command -v clojure &> /dev/null; then
    success "Clojure já instalado"
else
    info "Instalando Clojure CLI..."
    curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh
    chmod +x linux-install.sh
    sudo ./linux-install.sh
    rm -f linux-install.sh
    success "Clojure instalado"
fi

# clojure-lsp
if command -v clojure-lsp &> /dev/null; then
    success "clojure-lsp já instalado"
else
    info "Instalando clojure-lsp..."
    curl -L -o /tmp/clojure-lsp https://github.com/clojure-lsp/clojure-lsp/releases/latest/download/clojure-lsp-native-static-linux-amd64
    chmod +x /tmp/clojure-lsp
    sudo mv /tmp/clojure-lsp /usr/local/bin/
    success "clojure-lsp instalado"
fi

# Leiningen (gerenciador de projetos Clojure - facilita REPL com nREPL)
if command -v lein &> /dev/null; then
    success "Leiningen já instalado"
else
    info "Instalando Leiningen..."
    curl -fsSL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o /tmp/lein
    chmod +x /tmp/lein
    sudo mv /tmp/lein /usr/local/bin/
    # Primeira execução baixa o JAR do Leiningen
    info "Baixando Leiningen JAR (primeira execução)..."
    lein version
    success "Leiningen instalado"
fi

# ============================================
# Passo 8: Fontes (Nerd Fonts)
# ============================================
step "8/9 • Fontes (Nerd Fonts)"

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# JetBrains Mono Nerd Font
if ls "$FONT_DIR"/*JetBrains* &> /dev/null 2>&1; then
    success "JetBrains Mono Nerd Font já instalada"
else
    info "Instalando JetBrains Mono Nerd Font..."
    cd /tmp
    curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
    unzip -o JetBrainsMono.zip -d "$FONT_DIR"
    rm -f JetBrainsMono.zip
    success "JetBrains Mono Nerd Font instalada"
fi

# Meslo Nerd Font (usado pelo p10k)
if ls "$FONT_DIR"/*MesloLGS* &> /dev/null 2>&1; then
    success "MesloLGS Nerd Font já instalada"
else
    info "Instalando MesloLGS Nerd Font..."
    cd /tmp
    curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Meslo.zip
    unzip -o Meslo.zip -d "$FONT_DIR"
    rm -f Meslo.zip
    success "MesloLGS Nerd Font instalada"
fi

# Atualizar cache de fontes
info "Atualizando cache de fontes..."
fc-cache -fv > /dev/null 2>&1
success "Cache de fontes atualizado"

# ============================================
# Passo 9: tmux + Symlinks
# ============================================
step "9/9 • tmux + Symlinks"

# tmux - multiplexador de terminal (splits, tabs, sessões)
if command -v tmux &> /dev/null; then
    success "tmux já instalado"
else
    info "Instalando tmux..."
    sudo apt install -y tmux
    success "tmux instalado"
fi

# ============================================
# Symlinks
# ============================================
info "Criando symlinks..."

# Backup de arquivos existentes
backup_if_exists() {
    if [[ -f "$1" && ! -L "$1" ]]; then
        info "Backup: $1 → $1.backup"
        mv "$1" "$1.backup"
    fi
}

# Zsh (usando versão Linux)
backup_if_exists "$HOME/.zshrc"
ln -sf "$SANCTUM_DIR/config/zshrc-linux" "$HOME/.zshrc"
success "~/.zshrc → sanctum/config/zshrc-linux"

backup_if_exists "$HOME/.p10k.zsh"
ln -sf "$SANCTUM_DIR/config/p10k.zsh" "$HOME/.p10k.zsh"
success "~/.p10k.zsh → sanctum/config/p10k.zsh"

# Neovim
mkdir -p "$HOME/.config"
if [[ -L "$HOME/.config/nvim" ]]; then
    rm "$HOME/.config/nvim"
elif [[ -d "$HOME/.config/nvim" ]]; then
    info "Backup: ~/.config/nvim → ~/.config/nvim.backup"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
fi
ln -sf "$SANCTUM_DIR/config/nvim" "$HOME/.config/nvim"
success "~/.config/nvim → sanctum/config/nvim"

# tmux (usando config Linux)
backup_if_exists "$HOME/.tmux.conf"
ln -sf "$SANCTUM_DIR/config/tmux-linux.conf" "$HOME/.tmux.conf"
success "~/.tmux.conf → sanctum/config/tmux-linux.conf"

# Clojure LSP
mkdir -p "$HOME/.config/clojure-lsp"
ln -sf "$SANCTUM_DIR/config/clojure-lsp/config.edn" "$HOME/.config/clojure-lsp/config.edn"
success "~/.config/clojure-lsp/config.edn → sanctum/config/clojure-lsp/config.edn"

# Clojure deps.edn global
mkdir -p "$HOME/.clojure"
ln -sf "$SANCTUM_DIR/clojure/deps.edn" "$HOME/.clojure/deps.edn"
success "~/.clojure/deps.edn → sanctum/clojure/deps.edn"

# GPG Agent
mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"
ln -sf "$SANCTUM_DIR/gnupg/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"
success "~/.gnupg/gpg-agent.conf → sanctum/gnupg/gpg-agent.conf"

# ============================================
# Mudar shell padrão
# ============================================
if [[ "$SHELL" != *"zsh"* ]]; then
    info "Mudando shell padrão para zsh..."
    chsh -s "$(which zsh)"
fi

# ============================================
# Rodar doctor
# ============================================
echo ""
info "Executando sanctum-doctor para verificar instalação..."
echo ""

"$SANCTUM_DIR/scripts/doctor-windows.sh"

# Mensagem final
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                                     ║${NC}"
echo -e "${GREEN}║   ✨ Sanctum instalado com sucesso no WSL2!                        ║${NC}"
echo -e "${GREEN}║                                                                     ║${NC}"
echo -e "${GREEN}║   Próximos passos:                                                  ║${NC}"
echo -e "${GREEN}║   1. Feche e reabra o terminal (ou execute: source ~/.zshrc)       ║${NC}"
echo -e "${GREEN}║   2. Instale o Alacritty no Windows (veja instruções abaixo)       ║${NC}"
echo -e "${GREEN}║   3. Configure a fonte no Alacritty (JetBrainsMono Nerd Font)      ║${NC}"
echo -e "${GREEN}║   4. Execute 'p10k configure' se quiser reconfigurar o prompt      ║${NC}"
echo -e "${GREEN}║   5. Abra o Neovim (nvim) - plugins serão instalados automaticamente║${NC}"
echo -e "${GREEN}║                                                                     ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   📦 INSTALAR ALACRITTY NO WINDOWS:                               ║${NC}"
echo -e "${CYAN}║                                                                     ║${NC}"
echo -e "${CYAN}║   1. Abra o PowerShell no Windows e execute:                       ║${NC}"
echo -e "${CYAN}║      winget install Alacritty.Alacritty                            ║${NC}"
echo -e "${CYAN}║                                                                     ║${NC}"
echo -e "${CYAN}║   2. Baixe a fonte JetBrainsMono Nerd Font:                        ║${NC}"
echo -e "${CYAN}║      https://github.com/ryanoasis/nerd-fonts/releases              ║${NC}"
echo -e "${CYAN}║      → JetBrainsMono.zip → Extrair → Instalar as fontes           ║${NC}"
echo -e "${CYAN}║                                                                     ║${NC}"
echo -e "${CYAN}║   3. Crie o arquivo de config do Alacritty:                        ║${NC}"
echo -e "${CYAN}║      %APPDATA%\\alacritty\\alacritty.toml                            ║${NC}"
echo -e "${CYAN}║                                                                     ║${NC}"
echo -e "${CYAN}║   4. Cole a configuração (veja docs/wsl2-alacritty-config.md)      ║${NC}"
echo -e "${CYAN}║                                                                     ║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
