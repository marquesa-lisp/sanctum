# 🎯 ClojureDart + Neovim Setup Guide

Guia para configurar o ambiente de desenvolvimento ClojureDart com Neovim.

## 📚 O que é ClojureDart?

ClojureDart é um dialeto de Clojure que compila para Dart, permitindo criar apps mobile, desktop e web usando Flutter.

## 🛠️ Pré-requisitos

### 1. Java 8+
```bash
java -version
```

### 2. Clojure CLI Tools
```bash
# macOS
brew install clojure/tools/clojure

# Verificar
clj --version
```

### 3. Flutter SDK
```bash
# macOS
brew install --cask flutter

# Ou download manual: https://flutter.dev/docs/get-started/install

# Verificar instalação
flutter doctor
```

### 4. Neovim (com esta config do sanctum)
A configuração já inclui:
- ✅ Conjure (REPL integration)
- ✅ Treesitter (syntax highlighting)
- ✅ clojure-lsp (LSP support)
- ✅ Rainbow parens
- ✅ vim-sexp (paredit)

---

## 🚀 Criando um Projeto ClojureDart

### 1. Criar estrutura do projeto

```bash
mkdir meu-app && cd meu-app

cat << 'EOF' > deps.edn
{:paths ["src"]
 :deps {tensegritics/clojuredart
        {:git/url "https://github.com/tensegritics/ClojureDart.git"
         :sha "81b5c03a55cf52b21dc0be8ccfa4827b9889f488"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:kind :flutter
             :main acme.main}}
EOF
```

### 2. Inicializar projeto Flutter

```bash
clj -M:cljd init
```

### 3. Criar código fonte

```bash
mkdir -p src/acme
```

Criar `src/acme/main.cljd`:

```clojure
(ns acme.main
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

(defn main []
  (f/run
    (m/MaterialApp
      .title "Meu App"
      .theme (m/ThemeData .primarySwatch m.Colors/blue))
    .home
    (m/Scaffold
      .appBar (m/AppBar .title (m/Text "Olá ClojureDart!")))
    .body
    m/Center
    (m/Text "Vamos codar!" 
       .style (m/TextStyle .fontSize 24.0))))
```

### 4. Rodar o app

```bash
# Ver devices disponíveis
flutter devices

# Rodar (escolhe device automaticamente)
clj -M:cljd flutter

# Ou especificar device
clj -M:cljd flutter -d macos    # Desktop
clj -M:cljd flutter -d chrome   # Browser
clj -M:cljd flutter -d <id>     # Emulador específico
```

---

## 💻 Workflow no Neovim

### Estrutura de Janelas Recomendada

```
┌─────────────────────────────────────┬──────────────────────────┐
│                                     │                          │
│   Neovim                            │   Terminal               │
│   (editando .cljd)                  │   $ clj -M:cljd flutter  │
│                                     │                          │
│                                     │   🤫 REPL on port 59268  │
│                                     │   Reloaded!              │
│                                     │                          │
├─────────────────────────────────────┴──────────────────────────┤
│   Emulador / App Desktop / Browser                             │
└────────────────────────────────────────────────────────────────┘
```

### Ciclo de Desenvolvimento

1. **Edita** arquivo `.cljd` no Neovim
2. **Salva** (`:w`)
3. **Watcher detecta** automaticamente
4. **Hot Reload** atualiza o app
5. **Vê resultado** no emulador/device

### Comandos Úteis

| Comando | Descrição |
|---------|-----------|
| `clj -M:cljd flutter` | Inicia watcher + hot reload |
| `clj -M:cljd init` | Inicializa projeto Flutter |
| `clj -M:cljd upgrade` | Atualiza ClojureDart |
| `flutter devices` | Lista devices disponíveis |
| `flutter emulators` | Lista emuladores |
| `flutter emulators --launch <id>` | Inicia emulador |

---

## 🔌 REPL (Opcional)

O ClojureDart tem um socket REPL (beta). Quando você roda `clj -M:cljd flutter`, aparece:

```
🤫 ClojureDart REPL listening on port 59268
```

### Conectar via Terminal

```bash
nc localhost 59268
```

### Conectar via Conjure

```vim
:ConjureConnect localhost 59268
```

Ou usando o alias:
```vim
:Cjc localhost:59268
```

### Comandos do REPL

| Comando | Descrição |
|---------|-----------|
| `*1`, `*2`, `*3` | Últimos resultados |
| `*e` | Última exceção |
| `*env` | Ambiente do widget selecionado |
| `(pick!)` | Seleciona widget na tela |
| `(mount! widget)` | Substitui widget selecionado |

---

## 📖 Sintaxe Rápida

### Imports

```clojure
;; Dart lib (string com URI)
["package:flutter/material.dart" :as m]

;; ClojureDart namespace
[cljd.flutter :as f]
```

### Widgets

```clojure
;; Constructor
(m/Text "Hello")

;; Named parameters (keyword ou ponto)
(m/Text "Hello" :style (m/TextStyle :fontSize 20.0))
(m/Text "Hello" .style (m/TextStyle .fontSize 20.0))

;; Static members
m.Colors/blue
m/Icons.add
m/MainAxisAlignment.center
```

### Estado

```clojure
;; Atom (como em Clojure!)
(let [counter (atom 0)]
  (f/widget
    :watch [n counter]  ;; observa mudanças
    (m/Text (str n))))

;; Atualizar
(swap! counter inc)
(reset! counter 0)
```

### Widget Helper

```clojure
(f/widget
  :key my-key                    ;; local key
  :context ctx                   ;; acesso ao BuildContext
  :state [my-atom init-value]    ;; cria atom local
  :watch [val existing-atom]     ;; observa atom existente
  :get [m/Navigator]             ;; pega do context
  :with [controller (m/ScrollController.)]  ;; resource management
  ;; body - retorna Widget
  (m/Text "Hello"))
```

---

## 📂 Estrutura de Projeto

```
meu-app/
├── deps.edn              # Dependências Clojure
├── src/
│   └── acme/
│       └── main.cljd     # Código ClojureDart
├── lib/                  # Código Dart gerado (não editar)
├── pubspec.yaml          # Dependências Dart (gerado)
├── android/              # Config Android (gerado)
├── ios/                  # Config iOS (gerado)
└── ...
```

---

## 🔗 Recursos

- [ClojureDart GitHub](https://github.com/Tensegritics/ClojureDart)
- [ClojureDart Cheatsheet](https://github.com/Tensegritics/ClojureDart/blob/main/doc/ClojureDart%20Cheatsheet.pdf)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Slack #clojuredart](https://clojurians.slack.com/app_redirect?channel=clojuredart)
- [Conj 2023 Demo](https://www.youtube.com/watch?v=wbUBb09bUnk)
- [Conj 2025 REPL Demo](https://www.youtube.com/watch?v=ZLYnOTCRBbg)

---

## 🐛 Troubleshooting

### App não atualiza após salvar

Pressiona **Enter** no terminal do watcher para forçar restart.

### Erro de compilação

Verifica o terminal do watcher para ver o erro. Erros de sintaxe Clojure são bem claros.

### REPL não conecta

1. Verifica se o watcher está rodando
2. Verifica a porta correta no output
3. Tenta `nc localhost <porta>` primeiro

### Flutter doctor com problemas

```bash
flutter doctor -v
```

Segue as instruções para resolver cada item.
