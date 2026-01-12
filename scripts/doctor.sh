#!/bin/bash

# ╔═══════════════════════════════════════════════════════════════════╗
# ║                                                                     ║
# ║   🏥 SANCTUM DOCTOR                                                ║
# ║                                                                     ║
# ║   Verifica se todas as dependências estão instaladas corretamente  ║
# ║                                                                     ║
# ╚═══════════════════════════════════════════════════════════════════╝

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Contadores
PASS=0
FAIL=0
WARN=0

# Variáveis
SANCTUM_DIR="$HOME/dev/github/sanctum"

# Funções
check_pass() {
    echo -e "  ${GREEN}✓${NC} $1"
    ((PASS++))
}

check_fail() {
    echo -e "  ${RED}✗${NC} $1"
    ((FAIL++))
}

check_warn() {
    echo -e "  ${YELLOW}⚠${NC} $1"
    ((WARN++))
}

section() {
    echo ""
    echo -e "${PURPLE}${BOLD}$1${NC}"
    echo -e "${PURPLE}─────────────────────────────────────────${NC}"
}

# Header
echo ""
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                                                     ║${NC}"
echo -e "${CYAN}║   🏥 SANCTUM DOCTOR                                                ║${NC}"
echo -e "${CYAN}║                                                                     ║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"

# ============================================
# Sistema
# ============================================
section "Sistema"

if [[ "$OSTYPE" == "darwin"* ]]; then
    check_pass "macOS $(sw_vers -productVersion)"
else
    check_warn "Sistema: $OSTYPE (não é macOS)"
fi

# ============================================
# Ferramentas Base
# ============================================
section "Ferramentas Base"

if command -v brew &> /dev/null; then
    check_pass "Homebrew $(brew --version | head -1 | awk '{print $2}')"
else
    check_fail "Homebrew não instalado"
fi

if command -v git &> /dev/null; then
    check_pass "Git $(git --version | awk '{print $3}')"
else
    check_fail "Git não instalado"
fi

if xcode-select -p &> /dev/null; then
    check_pass "Xcode Command Line Tools"
else
    check_fail "Xcode Command Line Tools não instalado"
fi

# ============================================
# Repositório Sanctum
# ============================================
section "Repositório Sanctum"

if [[ -d "$SANCTUM_DIR" ]]; then
    check_pass "Repositório em $SANCTUM_DIR"
else
    check_fail "Repositório não encontrado em $SANCTUM_DIR"
fi

if [[ -f "$SANCTUM_DIR/artemis/Brewfile" ]]; then
    check_pass "Brewfile presente"
else
    check_fail "Brewfile não encontrado"
fi

# ============================================
# Shell
# ============================================
section "Shell & Terminal"

if [[ -d "$HOME/.oh-my-zsh" ]]; then
    check_pass "Oh My Zsh instalado"
else
    check_fail "Oh My Zsh não instalado"
fi

if command -v zsh &> /dev/null; then
    check_pass "Zsh $(zsh --version | awk '{print $2}')"
else
    check_fail "Zsh não instalado"
fi

if [[ -d "/opt/homebrew/share/powerlevel10k" ]] || [[ -d "/usr/local/share/powerlevel10k" ]]; then
    check_pass "Powerlevel10k instalado"
else
    check_fail "Powerlevel10k não instalado"
fi

if [[ -f "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    check_pass "zsh-syntax-highlighting"
else
    check_fail "zsh-syntax-highlighting não instalado"
fi

if [[ -d "/opt/homebrew/share/zsh-autosuggestions" ]]; then
    check_pass "zsh-autosuggestions"
else
    check_fail "zsh-autosuggestions não instalado"
fi

if command -v colorls &> /dev/null; then
    check_pass "colorls instalado"
else
    check_warn "colorls não instalado (gem install colorls)"
fi

# ============================================
# Symlinks
# ============================================
section "Symlinks"

if [[ -L "$HOME/.zshrc" ]] && [[ "$(readlink "$HOME/.zshrc")" == *"sanctum"* ]]; then
    check_pass "~/.zshrc → sanctum"
elif [[ -f "$HOME/.zshrc" ]]; then
    check_warn "~/.zshrc existe mas não é symlink para sanctum"
else
    check_fail "~/.zshrc não existe"
fi

if [[ -L "$HOME/.p10k.zsh" ]] && [[ "$(readlink "$HOME/.p10k.zsh")" == *"sanctum"* ]]; then
    check_pass "~/.p10k.zsh → sanctum"
elif [[ -f "$HOME/.p10k.zsh" ]]; then
    check_warn "~/.p10k.zsh existe mas não é symlink para sanctum"
else
    check_warn "~/.p10k.zsh não existe (execute p10k configure)"
fi

if [[ -L "$HOME/.config/nvim" ]] && [[ "$(readlink "$HOME/.config/nvim")" == *"sanctum"* ]]; then
    check_pass "~/.config/nvim → sanctum"
elif [[ -d "$HOME/.config/nvim" ]]; then
    check_warn "~/.config/nvim existe mas não é symlink para sanctum"
else
    check_fail "~/.config/nvim não existe"
fi

if [[ -L "$HOME/.config/clojure-lsp/config.edn" ]]; then
    check_pass "~/.config/clojure-lsp/config.edn → sanctum"
else
    check_warn "clojure-lsp config não é symlink"
fi

if [[ -L "$HOME/.clojure/deps.edn" ]]; then
    check_pass "~/.clojure/deps.edn → sanctum"
else
    check_warn "clojure deps.edn não é symlink"
fi

if [[ -L "$HOME/.gnupg/gpg-agent.conf" ]]; then
    check_pass "~/.gnupg/gpg-agent.conf → sanctum"
else
    check_warn "gpg-agent.conf não é symlink"
fi

# ============================================
# Editor
# ============================================
section "Editor & Dev Tools"

if command -v nvim &> /dev/null; then
    check_pass "Neovim $(nvim --version | head -1 | awk '{print $2}')"
else
    check_fail "Neovim não instalado"
fi

if command -v rg &> /dev/null; then
    check_pass "ripgrep (rg)"
else
    check_fail "ripgrep não instalado"
fi

if command -v lazygit &> /dev/null; then
    check_pass "lazygit"
else
    check_fail "lazygit não instalado"
fi

if command -v fzf &> /dev/null; then
    check_pass "fzf"
else
    check_fail "fzf não instalado"
fi

# ============================================
# Java
# ============================================
section "Java"

if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | head -1 | awk -F '"' '{print $2}')
    check_pass "Java $JAVA_VERSION"
else
    check_fail "Java não instalado"
fi

if [[ -n "$JAVA_HOME" ]]; then
    check_pass "JAVA_HOME definido: $JAVA_HOME"
else
    check_warn "JAVA_HOME não definido"
fi

# Verificar versões do OpenJDK
for version in 11 17 21; do
    if [[ -d "/opt/homebrew/opt/openjdk@$version" ]] || [[ -d "/usr/local/opt/openjdk@$version" ]]; then
        check_pass "OpenJDK $version disponível"
    else
        check_warn "OpenJDK $version não instalado"
    fi
done

# ============================================
# Clojure
# ============================================
section "Clojure"

if command -v clojure &> /dev/null; then
    check_pass "Clojure CLI instalado"
else
    check_fail "Clojure CLI não instalado"
fi

if command -v clojure-lsp &> /dev/null; then
    check_pass "clojure-lsp instalado"
else
    check_fail "clojure-lsp não instalado"
fi

if command -v rlwrap &> /dev/null; then
    check_pass "rlwrap instalado"
else
    check_warn "rlwrap não instalado (melhora REPL)"
fi

# ============================================
# Fontes
# ============================================
section "Fontes (Nerd Fonts)"

FONT_DIR="$HOME/Library/Fonts"

if ls "$FONT_DIR"/*MesloLGS* &> /dev/null 2>&1 || ls /Library/Fonts/*MesloLGS* &> /dev/null 2>&1; then
    check_pass "MesloLGS Nerd Font"
else
    check_warn "MesloLGS Nerd Font não encontrada"
fi

if ls "$FONT_DIR"/*JetBrains* &> /dev/null 2>&1 || ls /Library/Fonts/*JetBrains* &> /dev/null 2>&1; then
    check_pass "JetBrains Mono"
else
    check_warn "JetBrains Mono não encontrada"
fi

# ============================================
# Aplicativos
# ============================================
section "Aplicativos"

# Verificar iTerm2 em múltiplos locais
if [[ -d "/Applications/iTerm.app" ]] || [[ -d "$HOME/Applications/iTerm.app" ]] || pgrep -x "iTerm2" > /dev/null 2>&1; then
    check_pass "iTerm2 instalado"
else
    check_warn "iTerm2 não encontrado em /Applications (pode estar em outro local)"
fi

# ============================================
# Resumo
# ============================================
echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════${NC}"
echo ""

TOTAL=$((PASS + FAIL + WARN))

echo -e "  ${GREEN}✓ Passou:${NC}    $PASS"
echo -e "  ${YELLOW}⚠ Avisos:${NC}    $WARN"
echo -e "  ${RED}✗ Falhou:${NC}    $FAIL"
echo ""

if [[ $FAIL -eq 0 ]]; then
    if [[ $WARN -eq 0 ]]; then
        echo -e "${GREEN}${BOLD}  ✨ Tudo perfeito! Seu Sanctum está pronto.${NC}"
    else
        echo -e "${YELLOW}${BOLD}  ⚠️  Quase lá! Alguns avisos para verificar.${NC}"
    fi
else
    echo -e "${RED}${BOLD}  ❌ Alguns itens precisam de atenção.${NC}"
    echo -e "     Execute: ${CYAN}./install.sh${NC} para corrigir"
fi

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════${NC}"
echo ""

# Exit code baseado em falhas
exit $FAIL
