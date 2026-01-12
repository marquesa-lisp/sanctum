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
# ║                    Installation Script                              ║
# ╚═══════════════════════════════════════════════════════════════════╝

set -e

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

# Verificar se está no macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    error "Este script é apenas para macOS. Para Linux, veja o README."
fi

info "Detectado: macOS $(sw_vers -productVersion)"

# ============================================
# Passo 1: Xcode Command Line Tools
# ============================================
step "1/8 • Xcode Command Line Tools"

if xcode-select -p &> /dev/null; then
    success "Xcode Command Line Tools já instalado"
else
    info "Instalando Xcode Command Line Tools..."
    xcode-select --install
    
    # Aguardar instalação
    echo "Aguardando instalação do Xcode CLI Tools..."
    echo "Por favor, clique em 'Instalar' na janela que aparecer."
    until xcode-select -p &> /dev/null; do
        sleep 5
    done
    success "Xcode Command Line Tools instalado"
fi

# ============================================
# Passo 2: Homebrew
# ============================================
step "2/8 • Homebrew"

if command -v brew &> /dev/null; then
    success "Homebrew já instalado: $(brew --version | head -1)"
else
    info "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Adicionar ao PATH (Apple Silicon)
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    success "Homebrew instalado"
fi

# Atualizar Homebrew
info "Atualizando Homebrew..."
brew update

# ============================================
# Passo 3: Clonar repositório
# ============================================
step "3/8 • Clonar Sanctum"

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
# Passo 4: Brewfile (instala TUDO)
# ============================================
step "4/8 • Instalando pacotes (Brewfile)"

info "Isso pode demorar alguns minutos..."
info "Instalando: Git, Java, Clojure, Neovim, iTerm2, Fontes, etc."

brew bundle --file="$SANCTUM_DIR/artemis/Brewfile"

success "Todos os pacotes instalados"

# ============================================
# Passo 5: Oh My Zsh
# ============================================
step "5/8 • Oh My Zsh"

if [[ -d "$HOME/.oh-my-zsh" ]]; then
    success "Oh My Zsh já instalado"
else
    info "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    success "Oh My Zsh instalado"
fi

# ============================================
# Passo 6: colorls (Ruby gem)
# ============================================
step "6/8 • colorls"

if command -v colorls &> /dev/null; then
    success "colorls já instalado"
else
    info "Instalando colorls..."
    gem install colorls --user-install
    success "colorls instalado"
fi

# ============================================
# Passo 7: Symlinks
# ============================================
step "7/8 • Criando symlinks"

# Backup de arquivos existentes
backup_if_exists() {
    if [[ -f "$1" && ! -L "$1" ]]; then
        info "Backup: $1 → $1.backup"
        mv "$1" "$1.backup"
    fi
}

# Zsh
backup_if_exists "$HOME/.zshrc"
ln -sf "$SANCTUM_DIR/config/zshrc" "$HOME/.zshrc"
success "~/.zshrc → sanctum/config/zshrc"

backup_if_exists "$HOME/.p10k.zsh"
ln -sf "$SANCTUM_DIR/config/p10k.zsh" "$HOME/.p10k.zsh"
success "~/.p10k.zsh → sanctum/config/p10k.zsh"

# Neovim
mkdir -p "$HOME/.config"
if [[ -d "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]; then
    info "Backup: ~/.config/nvim → ~/.config/nvim.backup"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
fi
ln -sf "$SANCTUM_DIR/config/nvim" "$HOME/.config/nvim"
success "~/.config/nvim → sanctum/config/nvim"

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
# Passo 8: Finalização
# ============================================
step "8/8 • Finalizando"

# Mudar shell padrão para zsh (se não for)
if [[ "$SHELL" != *"zsh"* ]]; then
    info "Mudando shell padrão para zsh..."
    chsh -s "$(which zsh)"
fi

# Rodar doctor
echo ""
info "Executando sanctum-doctor para verificar instalação..."
echo ""

"$SANCTUM_DIR/scripts/doctor.sh"

# Mensagem final
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                                     ║${NC}"
echo -e "${GREEN}║   ✨ Sanctum instalado com sucesso!                                ║${NC}"
echo -e "${GREEN}║                                                                     ║${NC}"
echo -e "${GREEN}║   Próximos passos:                                                  ║${NC}"
echo -e "${GREEN}║   1. Feche e reabra o terminal (ou execute: source ~/.zshrc)       ║${NC}"
echo -e "${GREEN}║   2. Abra o iTerm2 e configure a fonte (MesloLGS NF)               ║${NC}"
echo -e "${GREEN}║   3. Execute 'p10k configure' se quiser reconfigurar o prompt      ║${NC}"
echo -e "${GREEN}║   4. Abra o Neovim (nvim) - plugins serão instalados automaticamente║${NC}"
echo -e "${GREEN}║                                                                     ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
