# Guia de Configuração do iTerm2

Este guia explica como configurar o iTerm2 usando os arquivos deste repositório.

## O que é o iTerm2?

O **iTerm2** é um emulador de terminal para macOS, muito mais poderoso que o Terminal.app padrão. Ele oferece:

- 🎨 Suporte a cores e temas customizados
- 📑 Múltiplas abas e painéis divididos
- 🔍 Busca com regex
- ⚡ Hotkey window (terminal que aparece com um atalho)
- 📸 Screenshots e gravação de sessão
- 🔗 Integração com shell (mostra diretório, git status, etc.)

## Instalação

### 1. Baixar o iTerm2

Baixe do site oficial: [iterm2.com](https://iterm2.com/)

Ou via Homebrew:
```bash
brew install --cask iterm2
```

### 2. Configurar para usar os arquivos do repositório

O iTerm2 pode carregar suas preferências de uma pasta customizada. Isso permite manter as configurações versionadas no Git.

1. Abra o **iTerm2**
2. Vá em `iTerm2` → `Settings` (ou `⌘,`)
3. Aba **General** → **Preferences**
4. Marque ✅ **"Load preferences from a custom folder or URL"**
5. Clique em **Browse** e selecione:
   ```
   ~/Dev/github/dotfiles/config/iterm2
   ```
6. Marque ✅ **"Save changes to folder when iTerm2 quits"**

![iTerm2 Preferences](iterm2-preferences.png)

### 3. Reinicie o iTerm2

Feche e abra novamente para carregar as novas configurações.

## Configuração Manual (Alternativa)

Se preferir não usar a sincronização automática, você pode importar manualmente:

### Importar o arquivo plist

```bash
# Backup das configurações atuais
cp ~/Library/Preferences/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist.backup

# Copiar as configurações do repositório
cp ~/Dev/github/dotfiles/config/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/
```

**Nota:** Você precisará reiniciar o iTerm2 após copiar o arquivo.

## Exportar Temas de Cores

Se você criou ou customizou um tema de cores e quer salvá-lo separadamente:

1. Vá em `iTerm2` → `Settings` → `Profiles`
2. Selecione o profile desejado
3. Aba **Colors**
4. No canto inferior direito, clique em **Color Presets...**
5. Selecione **Export...**
6. Salve o arquivo `.itermcolors` em:
   ```
   ~/Dev/github/dotfiles/config/iterm2/themes/
   ```

### Importar Temas de Cores

Para importar um tema `.itermcolors`:

1. Vá em `iTerm2` → `Settings` → `Profiles`
2. Selecione o profile desejado
3. Aba **Colors**
4. Clique em **Color Presets...** → **Import...**
5. Selecione o arquivo `.itermcolors`

## Profiles Recomendados

### Configurações de Fonte

Para ter os ícones do Powerlevel10k funcionando corretamente:

1. Vá em `Profiles` → `Text`
2. Em **Font**, selecione uma **Nerd Font**:
   - `MesloLGS NF` (recomendado pelo p10k)
   - `JetBrainsMono Nerd Font`
   - `FiraCode Nerd Font`
3. Tamanho recomendado: **14pt**
4. Marque ✅ **Use ligatures** (para FiraCode)

### Configurações de Cores

Temas populares que combinam com o setup:
- **Kanagawa** - Tema inspirado em arte japonesa
- **Tairiki** - Tema escuro com tons de roxo
- **Catppuccin** - Tema pastel moderno
- **Dracula** - Clássico tema escuro

## Atalhos Úteis

| Atalho | Ação |
|--------|------|
| `⌘D` | Dividir painel verticalmente |
| `⌘⇧D` | Dividir painel horizontalmente |
| `⌘T` | Nova aba |
| `⌘W` | Fechar aba/painel atual |
| `⌘[` / `⌘]` | Navegar entre painéis |
| `⌘←` / `⌘→` | Navegar entre abas |
| `⌘F` | Buscar no terminal |
| `⌘⇧H` | Histórico de comandos |
| `⌘;` | Autocomplete |

## Troubleshooting

### Ícones não aparecem corretamente

Se você vê caracteres estranhos no lugar dos ícones:

1. Verifique se instalou as Nerd Fonts:
   ```bash
   brew install --cask font-meslo-lg-nerd-font
   ```
2. Configure a fonte no iTerm2 para usar a Nerd Font
3. Execute `p10k configure` para reconfigurar o Powerlevel10k

### Cores estão erradas

1. Verifique se o profile correto está selecionado
2. Em `Profiles` → `Colors`, verifique o **Color Preset**
3. Certifique-se que o `TERM` está configurado corretamente no zshrc:
   ```bash
   export TERM="xterm-256color"
   ```

### Configurações não estão sendo salvas

1. Verifique se a opção "Save changes to folder when iTerm2 quits" está marcada
2. Verifique permissões da pasta:
   ```bash
   ls -la ~/Dev/github/dotfiles/config/iterm2/
   ```

## Links Úteis

- [iTerm2 Documentation](https://iterm2.com/documentation.html)
- [iTerm2 Color Schemes](https://iterm2colorschemes.com/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Nerd Fonts](https://www.nerdfonts.com/)
