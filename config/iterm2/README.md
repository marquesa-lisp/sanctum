# iTerm2 Configuration

Esta pasta contém as configurações do iTerm2.

## Estrutura

```
iterm2/
├── com.googlecode.iterm2.plist   # Configurações principais do iTerm2
├── profiles/                      # Profiles completos (.json)
│   └── nubank.json               # Profile Nubank (cores + fonte + status bar)
├── themes/                        # Temas de cores (.itermcolors)
└── README.md                      # Este arquivo
```

## Diferença entre Profiles e Themes

| Tipo | Extensão | O que contém |
|------|----------|--------------|
| **Profile** | `.json` | Configuração completa: cores, fonte, status bar, atalhos, etc. |
| **Theme** | `.itermcolors` | Apenas o esquema de cores |

## Como usar

### Opção 1: Sincronização automática (recomendado)

1. Abra o iTerm2
2. Vá em `Settings` → `General` → `Preferences`
3. Marque "Load preferences from a custom folder or URL"
4. Selecione esta pasta: `~/Dev/github/dotfiles/config/iterm2`
5. Marque "Save changes to folder when iTerm2 quits"

### Opção 2: Importar um Profile manualmente

1. iTerm2 → Settings → Profiles
2. Clique no `+` (ou use o menu `Other Actions`)
3. Selecione "Import JSON Profiles..."
4. Escolha o arquivo da pasta `profiles/`

### Opção 3: Usar Dynamic Profiles (avançado)

Copie os profiles para a pasta de Dynamic Profiles do iTerm2:
```bash
cp profiles/*.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/
```

## Profiles Disponíveis

### Nubank (`profiles/nubank.json`)
- **Cores**: Tema escuro com tons de roxo/verde (estilo Nubank)
- **Fonte**: MesloLGS-NF-Regular 20pt
- **Status Bar**: Network, CPU, Memory, Clock, Git
- **Cursor**: Blinking, cor verde

## Exportar seus Profiles

### Exportar Profile completo (JSON)
1. iTerm2 → Settings → Profiles
2. Selecione o profile
3. Other Actions → Copy Profile as JSON
4. Salve na pasta `profiles/`

### Exportar apenas cores (itermcolors)
1. iTerm2 → Settings → Profiles → Colors
2. Color Presets → Export...
3. Salve na pasta `themes/`

## Guia completo

Veja o [Guia Completo do iTerm2](../../docs/iterm2-guide.md) para mais detalhes.
