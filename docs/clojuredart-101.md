# 🎯 ClojureDart 101 - Do Zero ao Primeiro App

Um guia completo para iniciantes em desenvolvimento mobile com ClojureDart e Flutter.

---

## 📚 Índice

1. [O que é ClojureDart?](#-o-que-é-clojuredart)
2. [ClojureDart vs ClojureScript](#-clojuredart-vs-clojurescript)
3. [Conceitos Fundamentais de Flutter](#-conceitos-fundamentais-de-flutter)
4. [Pré-requisitos e Instalação](#-pré-requisitos-e-instalação)
5. [Seu Primeiro App](#-seu-primeiro-app)
6. [Sintaxe ClojureDart](#-sintaxe-clojuredart)
7. [Widgets Essenciais](#-widgets-essenciais)
8. [Gerenciamento de Estado](#-gerenciamento-de-estado)
9. [Navegação entre Telas](#-navegação-entre-telas)
10. [HTTP e Operações Assíncronas](#-http-e-operações-assíncronas)
11. [Formulários](#-formulários)
12. [Macros e Helpers](#-macros-e-helpers-do-cljdflutter)
13. [REPL (Opcional)](#-repl-opcional)
14. [Diferenças com Clojure](#-diferenças-com-clojure)
15. [Recursos e Próximos Passos](#-recursos-e-próximos-passos)

---

## 🌟 O que é ClojureDart?

**ClojureDart** é um dialeto de Clojure que compila para **Dart**, a linguagem do Flutter. Com ele, você pode criar aplicativos nativos para:

- 📱 **iOS** e **Android**
- 🖥️ **Desktop** (macOS, Windows, Linux)
- 🌐 **Web** (browsers)

### Por que usar ClojureDart?

| Vantagem | Descrição |
|----------|-----------|
| **Clojure** | Linguagem funcional, imutabilidade, REPL-driven development |
| **Flutter** | Um código, múltiplas plataformas, hot reload, UI rica |
| **Produtivo** | Menos boilerplate que Dart/Flutter puro |
| **Production-ready** | Apps em produção (ex: Roam Research mobile) |

### Quem criou?

Baptiste Dupuch e Christophe Grand — o mesmo Christophe Grand que criou o Enlive e outras libs famosas do ecossistema Clojure.

---

## 🆚 ClojureDart vs ClojureScript

Se você conhece ClojureScript, aqui está a comparação:

```
ClojureScript:
  Clojure → JavaScript → Browser/Node.js
                       → React (Reagent/Re-frame)
                       → DOM/HTML/CSS

ClojureDart:
  Clojure → Dart → Flutter Runtime
                 → Widgets (não DOM!)
                 → Skia Engine (canvas)
```

### Tabela Comparativa

| Aspecto | ClojureScript | ClojureDart |
|---------|---------------|-------------|
| **Compila para** | JavaScript | Dart |
| **Plataforma** | Web (browser/Node) | Mobile/Desktop/Web |
| **UI Framework** | React (DOM) | Flutter (Skia/Canvas) |
| **Maturidade** | ~10+ anos | ~4 anos |
| **REPL** | Muito maduro | Beta (mas hot reload compensa) |
| **Hot Reload** | Via figwheel/shadow-cljs | Via Flutter (muito rápido) |

### O que você precisa aprender?

| ClojureScript | ClojureDart |
|---------------|-------------|
| HTML, CSS, JavaScript | ❌ Não precisa |
| React (componentes, estado) | ❌ Não precisa |
| — | ✅ Flutter/Widgets |
| — | ✅ Material Design (básico) |

**Boa notícia**: Você NÃO precisa aprender Dart profundamente. O ClojureDart abstrai a sintaxe. Você só precisa entender os **conceitos** do Flutter.

---

## 🧱 Conceitos Fundamentais de Flutter

Antes de codar, entenda estes conceitos:

### 1. Tudo é Widget

No Flutter, **tudo na tela é um Widget**:
- Texto? Widget (`Text`)
- Botão? Widget (`ElevatedButton`)
- Layout? Widget (`Column`, `Row`, `Center`)
- Padding? Widget (`Padding`)
- A tela inteira? Widget (`Scaffold`)

### 2. Widget Tree (Árvore de Widgets)

Widgets são aninhados formando uma árvore:

```
MaterialApp
└── Scaffold
    ├── AppBar
    │   └── Text ("Título")
    └── Center
        └── Column
            ├── Text ("Olá")
            └── ElevatedButton
                └── Text ("Clique")
```

### 3. Stateless vs Stateful

| Tipo | Descrição | Exemplo |
|------|-----------|---------|
| **Stateless** | Não muda depois de criado | Texto fixo, ícone |
| **Stateful** | Pode mudar com o tempo | Contador, formulário |

**Em ClojureDart**: Usamos `atoms` para estado, como em Clojure!

### 4. BuildContext

O `BuildContext` é como o widget "sabe" onde está na árvore. Usado para:
- Acessar tema atual
- Navegar entre telas
- Mostrar dialogs/snackbars

### 5. Material Design

Flutter vem com widgets Material Design prontos:
- `AppBar`, `Scaffold`, `Card`
- `ElevatedButton`, `TextButton`, `FloatingActionButton`
- `TextField`, `Checkbox`, `Switch`
- `BottomNavigationBar`, `Drawer`, `TabBar`

---

## 🛠️ Pré-requisitos e Instalação

### 1. Java 8+ (para compilação Clojure)

```bash
# Verificar
java -version

# macOS (se não tiver)
brew install openjdk@17
```

### 2. Clojure CLI Tools

```bash
# macOS
brew install clojure/tools/clojure

# Linux
curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh
chmod +x linux-install.sh
sudo ./linux-install.sh

# Verificar
clj --version
```

### 3. Flutter SDK

```bash
# macOS
brew install --cask flutter

# Ou download manual
# https://docs.flutter.dev/get-started/install

# Verificar instalação completa
flutter doctor
```

O `flutter doctor` vai mostrar o que falta configurar (Xcode, Android Studio, etc).

### 4. Device/Emulador

Você precisa de algo para rodar o app:

| Opção | Como configurar |
|-------|-----------------|
| **Desktop (mais fácil!)** | Já funciona, sem config extra |
| **Chrome/Web** | Já funciona se tiver Chrome |
| **iOS Simulator** | Instala Xcode, roda `open -a Simulator` |
| **Android Emulator** | Instala Android Studio, cria AVD |
| **Celular físico** | Conecta via USB, habilita debug |

**Dica para começar**: Use **desktop** ou **Chrome**. Zero configuração extra!

```bash
# Ver devices disponíveis
flutter devices

# Exemplo de saída:
# macOS (desktop) • macos  • darwin-arm64
# Chrome (web)    • chrome • web-javascript
```

---

## 🚀 Seu Primeiro App

### Passo 1: Criar estrutura do projeto

```bash
mkdir hello-cljd
cd hello-cljd
```

Criar `deps.edn`:

```clojure
{:paths ["src"]
 :deps {tensegritics/clojuredart
        {:git/url "https://github.com/tensegritics/ClojureDart.git"
         :sha "81b5c03a55cf52b21dc0be8ccfa4827b9889f488"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:kind :flutter
             :main acme.main}}
```

### Passo 2: Inicializar projeto Flutter

```bash
clj -M:cljd init
```

Isso cria toda estrutura Flutter (`pubspec.yaml`, `android/`, `ios/`, etc).

### Passo 3: Criar código fonte

```bash
mkdir -p src/acme
```

Criar `src/acme/main.cljd`:

```clojure
(ns acme.main
  (:require 
    ;; Importa biblioteca Dart do Flutter
    ["package:flutter/material.dart" :as m]
    ;; Importa helpers do ClojureDart
    [cljd.flutter :as f]))

(defn main []
  ;; f/run inicializa o app Flutter
  (f/run
    ;; Widget raiz: MaterialApp configura tema, rotas, etc
    (m/MaterialApp
      .title "Hello ClojureDart"
      .theme (m/ThemeData .primarySwatch m.Colors/blue))
    ;; .home define a tela inicial
    .home
    ;; Scaffold: estrutura básica de tela (appbar, body, fab)
    (m/Scaffold
      .appBar (m/AppBar 
                .title (m/Text "Meu Primeiro App")))
    ;; .body define o conteúdo principal
    .body
    ;; Center: centraliza o filho
    m/Center
    ;; Text: exibe texto
    (m/Text "Olá, ClojureDart!" 
       .style (m/TextStyle 
                .fontSize 24.0
                .fontWeight m.FontWeight/bold
                .color m.Colors/indigo))))
```

### Passo 4: Rodar!

```bash
# Roda no device padrão (geralmente desktop)
clj -M:cljd flutter

# Ou especifica o device
clj -M:cljd flutter -d chrome
clj -M:cljd flutter -d macos
```

🎉 **Parabéns!** Você tem um app rodando!

### Passo 5: Hot Reload

Agora edita o texto em `main.cljd`, salva, e vê a mágica:
- O watcher detecta a mudança
- Compila o código
- Hot reload atualiza o app
- **Tudo em ~1-3 segundos!**

---

## 📖 Sintaxe ClojureDart

### Imports

```clojure
(ns meu.namespace
  (:require 
    ;; Bibliotecas Dart: string com URI do package
    ["package:flutter/material.dart" :as m]
    ["package:http/http.dart" :as http]
    ["dart:convert" :as convert]
    ["dart:async" :as async]
    
    ;; Namespaces ClojureDart: símbolo normal
    [cljd.flutter :as f]
    [outro.namespace :refer [minha-fn]]))
```

### Criando Instâncias (Constructors)

```clojure
;; Três formas equivalentes:
(m/Text "Hello")      ;; sem ponto (preferido em cljd)
(m/Text. "Hello")     ;; com ponto (estilo Clojure)
(new m/Text "Hello")  ;; com new (raramente usado)
```

### Parâmetros Nomeados (Named Parameters)

Dart usa named parameters extensivamente. Em ClojureDart:

```clojure
;; Com keyword (estilo Clojure)
(m/Text "Hello" :style my-style :textAlign m/TextAlign.center)

;; Com ponto (estilo Dart-ish)
(m/Text "Hello" .style my-style .textAlign m/TextAlign.center)

;; Ambos são equivalentes, escolha seu preferido!
```

### Acessando Membros Estáticos

```clojure
;; Padrão: Alias.Classe/membro
m.Colors/blue
m.Colors/red
m.Icons/add
m.Icons/home
m.FontWeight/bold
m.MainAxisAlignment/center

;; Alternativa: Alias/Classe.membro
m/Colors.blue
m/Icons.add
```

### Chamando Métodos

```clojure
;; Método de instância
(.toString obj)
(.add lista item)

;; Acessando propriedade
(.-length lista)
(.-statusCode response)

;; Encadeamento
(-> response .-body)
(-> obj .method1 .method2)
```

### Funções Anônimas (Lambdas)

```clojure
;; Função anônima normal
(fn [x] (+ x 1))

;; Shorthand
#(+ % 1)

;; Como callback
(m/ElevatedButton
  .onPressed #(println "Clicado!")
  .child (m/Text "Clique"))

;; Com múltiplos statements
(m/ElevatedButton
  .onPressed (fn []
               (println "Fazendo algo...")
               (swap! counter inc)
               nil)  ;; callbacks geralmente retornam nil
  .child (m/Text "Ação"))
```

### Coleções

```clojure
;; Vetores Clojure funcionam como List<dynamic> do Dart
[widget1 widget2 widget3]

;; Para List tipada, use cast ou type hint quando necessário
;; (geralmente não precisa, ClojureDart faz automaticamente)

;; Dart List literal (raramente necessário)
#dart [1 2 3]

;; Maps funcionam normalmente
{:key "value" :outro "valor"}
```

### Async/Await

```clojure
;; await é uma macro que funciona direto!
(defn fetch-data []
  (let [response (await (http/get uri))]
    (.-body response)))

;; Funções que usam await são automaticamente async
;; Não precisa marcar com ^:async (mas pode se quiser ser explícito)
```

---

## 🎨 Widgets Essenciais

### Layout Widgets

```clojure
;; Center: centraliza o filho
(m/Center
  .child (m/Text "Centralizado"))

;; Column: empilha filhos verticalmente
(m/Column
  .mainAxisAlignment m/MainAxisAlignment.center
  .crossAxisAlignment m/CrossAxisAlignment.start
  .children [(m/Text "Primeiro")
             (m/Text "Segundo")
             (m/Text "Terceiro")])

;; Row: alinha filhos horizontalmente
(m/Row
  .mainAxisAlignment m/MainAxisAlignment.spaceEvenly
  .children [(m/Icon m/Icons.star)
             (m/Icon m/Icons.star)
             (m/Icon m/Icons.star)])

;; Container: box model (padding, margin, decoration)
(m/Container
  .padding (m/EdgeInsets.all 16.0)
  .margin (m/EdgeInsets.symmetric .vertical 8.0)
  .decoration (m/BoxDecoration
                .color m.Colors/white
                .borderRadius (m/BorderRadius.circular 8.0)
                .boxShadow [(m/BoxShadow
                              .color (m/Color 0x1A000000)
                              .blurRadius 4.0)])
  .child (m/Text "Conteúdo"))

;; Padding: só padding (mais leve que Container)
(m/Padding
  .padding (m/EdgeInsets.all 16.0)
  .child (m/Text "Com padding"))

;; SizedBox: tamanho fixo ou espaçamento
(m/SizedBox .height 20.0)  ;; espaçamento vertical
(m/SizedBox .width 100.0 .height 50.0
  .child (m/Text "Tamanho fixo"))

;; Expanded: ocupa espaço disponível (dentro de Row/Column)
(m/Row
  .children [(m/Expanded .child (m/Text "Expande"))
             (m/Text "Fixo")])

;; ListView: lista scrollável
(m/ListView
  .children [(m/ListTile .title (m/Text "Item 1"))
             (m/ListTile .title (m/Text "Item 2"))
             (m/ListTile .title (m/Text "Item 3"))])

;; ListView.builder: para listas grandes (lazy)
(m/ListView.builder
  .itemCount 100
  .itemBuilder (fn [ctx index]
                 (m/ListTile 
                   .title (m/Text (str "Item " index)))))
```

### Widgets de Entrada

```clojure
;; Botões
(m/ElevatedButton
  .onPressed #(println "Clicado!")
  .child (m/Text "Elevated"))

(m/TextButton
  .onPressed #(println "Clicado!")
  .child (m/Text "Text Button"))

(m/IconButton
  .onPressed #(println "Clicado!")
  .icon (m/Icon m/Icons.favorite))

(m/FloatingActionButton
  .onPressed #(println "FAB!")
  .child (m/Icon m/Icons.add))

;; TextField
(m/TextField
  .decoration (m/InputDecoration
                .labelText "Nome"
                .hintText "Digite seu nome"
                .border (m/OutlineInputBorder)))

;; Checkbox
(m/Checkbox
  .value true
  .onChanged (fn [value] (println "Mudou para:" value)))

;; Switch
(m/Switch
  .value false
  .onChanged (fn [value] (println "Toggle:" value)))
```

### Widgets de Estrutura

```clojure
;; Scaffold: estrutura básica de tela
(m/Scaffold
  .appBar (m/AppBar .title (m/Text "Título"))
  .body (m/Center .child (m/Text "Conteúdo"))
  .floatingActionButton (m/FloatingActionButton
                          .onPressed #(println "FAB!")
                          .child (m/Icon m/Icons.add))
  .bottomNavigationBar (m/BottomNavigationBar
                         .items [(m/BottomNavigationBarItem
                                   .icon (m/Icon m/Icons.home)
                                   .label "Home")
                                 (m/BottomNavigationBarItem
                                   .icon (m/Icon m/Icons.settings)
                                   .label "Config")]))

;; Card
(m/Card
  .elevation 4.0
  .child (m/Padding
           .padding (m/EdgeInsets.all 16.0)
           .child (m/Text "Conteúdo do card")))

;; AppBar customizada
(m/AppBar
  .title (m/Text "Título")
  .centerTitle true
  .backgroundColor m.Colors/indigo
  .actions [(m/IconButton
              .icon (m/Icon m/Icons.search)
              .onPressed #(println "Buscar"))
            (m/IconButton
              .icon (m/Icon m/Icons.more_vert)
              .onPressed #(println "Menu"))])
```

---

## 🔄 Gerenciamento de Estado

### Estado com Atoms

Em ClojureDart, usamos `atoms` como em Clojure!

```clojure
(ns app.counter
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

(defn main []
  ;; Cria atom fora do widget para persistir entre rebuilds
  (let [counter (atom 0)]
    (f/run
      (m/MaterialApp .title "Counter")
      .home
      (m/Scaffold
        .appBar (m/AppBar .title (m/Text "Contador"))
        .floatingActionButton
        (m/FloatingActionButton
          ;; swap! incrementa o atom
          .onPressed #(swap! counter inc)
          .child (m/Icon m/Icons.add)))
      .body
      m/Center
      ;; f/widget com :watch observa mudanças no atom
      (f/widget
        :watch [n counter]  ;; n = valor atual de counter
        (m/Text (str n)
          .style (m/TextStyle .fontSize 48.0))))))
```

### Múltiplos Estados

```clojure
(defn main []
  (let [name (atom "")
        count (atom 0)
        items (atom [])]
    (f/run
      (m/MaterialApp)
      .home
      (m/Scaffold)
      .body
      (f/widget
        ;; Observa múltiplos atoms
        :watch [n count
                nome name
                lista items]
        (m/Column
          .children
          [(m/Text (str "Nome: " nome))
           (m/Text (str "Count: " n))
           (m/Text (str "Items: " (count lista)))])))))
```

### Estado Local com :state

```clojure
;; :state cria um atom local ao widget
(f/widget
  :state [counter 0]  ;; cria (atom 0) chamado counter
  (m/Column
    .children
    [(m/Text (str @counter))
     (m/ElevatedButton
       .onPressed #(swap! counter inc)
       .child (m/Text "Incrementar"))]))
```

### Acessando Dados do Contexto com :get

```clojure
;; :get extrai valores do BuildContext
(f/widget
  ;; Pega o Navigator do contexto
  :get [m/Navigator]
  (m/ElevatedButton
    .onPressed #(.pop navigator)
    .child (m/Text "Voltar")))

;; Pega tema e extrai propriedades
(f/widget
  :get {{{:flds [displayLarge]} .-textTheme} m/Theme}
  (m/Text "Grande" .style displayLarge))

;; Pega MediaQuery para tamanho de tela
(f/widget
  :get [{:flds [size]} m/MediaQuery]
  (m/Text (str "Largura: " (.-width size))))
```

---

## 🧭 Navegação entre Telas

### Navegação Básica (Push/Pop)

```clojure
(ns app.navigation
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

;; Segunda tela
(def second-screen
  (m/Scaffold
    .appBar (m/AppBar .title (m/Text "Segunda Tela"))
    .body
    (f/widget
      :get [m/Navigator]
      m/Center
      (m/ElevatedButton
        .onPressed #(.pop navigator)  ;; Volta
        .child (m/Text "Voltar")))))

;; Primeira tela
(def first-screen
  (m/Scaffold
    .appBar (m/AppBar .title (m/Text "Primeira Tela"))
    .body
    (f/widget
      :get [m/Navigator]
      m/Center
      (m/ElevatedButton
        .onPressed (fn []
                     ;; Push nova tela
                     (.push navigator
                       (#/(m/MaterialPageRoute Object)
                         .builder (f/build second-screen)))
                     nil)
        .child (m/Text "Ir para Segunda")))))

(defn main []
  (m/runApp
    (m/MaterialApp
      .title "Navigation Demo"
      .home first-screen)))
```

### Navegação com Rotas Nomeadas

```clojure
(defn main []
  (m/runApp
    (m/MaterialApp
      .title "Named Routes"
      .initialRoute "/"
      .routes {"/" (f/build home-screen)
               "/details" (f/build details-screen)
               "/settings" (f/build settings-screen)})))

;; Navegar para rota nomeada
(f/widget
  :get [m/Navigator]
  (m/ElevatedButton
    .onPressed #(.pushNamed navigator "/details")
    .child (m/Text "Ver Detalhes")))
```

### Passando Dados entre Telas

```clojure
;; Passando dados no push
(.push navigator
  (#/(m/MaterialPageRoute Object)
    .builder (fn [ctx]
               (details-screen {:id 123 :name "Item"}))))

;; Recebendo dados (a tela recebe como argumento)
(defn details-screen [{:keys [id name]}]
  (m/Scaffold
    .appBar (m/AppBar .title (m/Text name))
    .body (m/Center .child (m/Text (str "ID: " id)))))
```

---

## 🌐 HTTP e Operações Assíncronas

### Fetch de Dados

```clojure
(ns app.fetch
  (:require ["dart:convert" :as c]
            ["package:flutter/material.dart" :as m]
            ["package:http/http.dart" :as http]
            [cljd.flutter :as f]))

(defn main []
  (f/run
    (m/MaterialApp .title "Fetch Demo")
    .home
    (m/Scaffold .appBar (m/AppBar .title (m/Text "API")))
    .body
    m/Center
    ;; :watch pode observar Futures!
    :watch [response (http/get 
                       (Uri/parse "https://jsonplaceholder.typicode.com/posts/1"))]
    ;; Enquanto carrega, response é nil
    (if-some [{status .-statusCode body .-body} response]
      (case status
        200 (let [data (c/json.decode body)]
              (m/Padding
                .padding (m/EdgeInsets.all 16.0)
                .child (m/Text (get data "title"))))
        (m/Text (str "Erro: " status)))
      ;; Loading state
      (m/CircularProgressIndicator))))
```

### POST Request

```clojure
(defn create-post [title body]
  (let [response (await (http/post 
                          (Uri/parse "https://api.example.com/posts")
                          .headers {"Content-Type" "application/json"}
                          .body (c/json.encode {"title" title 
                                                 "body" body})))]
    (if (= 201 (.-statusCode response))
      (c/json.decode (.-body response))
      (throw (ex-info "Failed to create" {:status (.-statusCode response)})))))
```

### Async/Await Pattern

```clojure
;; Funções que usam await são automaticamente async
(defn fetch-user [id]
  (let [response (await (http/get (Uri/parse (str "https://api.example.com/users/" id))))]
    (when (= 200 (.-statusCode response))
      (c/json.decode (.-body response)))))

;; Múltiplas chamadas em sequência
(defn fetch-user-with-posts [user-id]
  (let [user (await (fetch-user user-id))
        posts (await (http/get (Uri/parse (str "https://api.example.com/users/" user-id "/posts"))))]
    {:user user
     :posts (c/json.decode (.-body posts))}))
```

---

## 📝 Formulários

### TextField com Controller

```clojure
(ns app.form
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

(defn main []
  (f/run
    (m/MaterialApp)
    .home
    (m/Scaffold .appBar (m/AppBar .title (m/Text "Formulário")))
    .body
    (f/widget
      ;; :with gerencia lifecycle (init/dispose)
      :with [controller (m/TextEditingController)]
      (m/Padding
        .padding (m/EdgeInsets.all 16.0)
        .child (m/Column
                 .children
                 [(m/TextField
                    .controller controller
                    .decoration (m/InputDecoration
                                  .labelText "Nome"
                                  .border (m/OutlineInputBorder)))
                  (m/SizedBox .height 16.0)
                  (m/ElevatedButton
                    .onPressed (fn []
                                 (println "Nome:" (.-text controller)))
                    .child (m/Text "Enviar"))])))))
```

### Validação de Formulário

```clojure
(defn main []
  (f/run
    (m/MaterialApp)
    .home
    (m/Scaffold)
    .body
    (f/widget
      :with [form-key (m/GlobalKey)]
      (m/Form
        .key form-key
        .child (m/Padding
                 .padding (m/EdgeInsets.all 16.0)
                 .child (m/Column
                          .children
                          [(m/TextFormField
                             .decoration (m/InputDecoration .labelText "Email")
                             .validator (fn [value]
                                          (when (or (nil? value) 
                                                    (not (.contains value "@")))
                                            "Email inválido")))
                           (m/SizedBox .height 16.0)
                           (m/ElevatedButton
                             .onPressed (fn []
                                          (when (.validate (.-currentState form-key))
                                            (println "Formulário válido!")))
                             .child (m/Text "Validar"))]))))))
```

---

## 🧰 Macros e Helpers do cljd.flutter

### f/run - Inicializador do App

`f/run` remove boilerplate de aninhamento:

```clojure
;; Sem f/run (muito aninhado)
(m/runApp
  (m/MaterialApp
    .home
    (m/Scaffold
      .body
      (m/Center
        .child (m/Text "Hello")))))

;; Com f/run (flat)
(f/run
  (m/MaterialApp)
  .home
  (m/Scaffold)
  .body
  m/Center
  (m/Text "Hello"))
```

### f/widget - Swiss Army Knife

```clojure
(f/widget
  ;; :key - identificador único (para listas)
  :key item-id
  
  ;; :context - acesso ao BuildContext
  :context ctx
  
  ;; :state - cria atom local
  :state [counter 0]
  
  ;; :watch - observa atoms/futures
  :watch [n counter]
  
  ;; :get - extrai do contexto
  :get [m/Navigator]
  :get {theme m/Theme}
  
  ;; :with - gerencia recursos (init/dispose)
  :with [controller (m/TextEditingController)
         :dispose .dispose]  ;; método de cleanup
  
  ;; :ticker/:tickers - para animações
  :ticker ticker
  
  ;; body - retorna Widget
  (m/Text (str n)))
```

### f/nest - Achata Aninhamento

```clojure
;; Em vez de:
(m/IgnorePointer
  .child (m/AnimatedContainer
           .child (m/AnimatedOpacity
                    .child (m/FloatingActionButton
                             .child (m/Icon m/Icons.add)))))

;; Use:
(f/nest
  (m/IgnorePointer)
  (m/AnimatedContainer)
  (m/AnimatedOpacity)
  (m/FloatingActionButton)
  (m/Icon m/Icons.add))
```

---

## 🔌 REPL (Opcional)

O REPL do ClojureDart é beta mas funciona:

### Conectar

Quando você roda `clj -M:cljd flutter`, aparece:

```
🤫 ClojureDart REPL listening on port 59268
```

Conecte via terminal:
```bash
nc localhost 59268
```

### Comandos Úteis

```clojure
;; Últimos resultados
*1 *2 *3

;; Última exceção
*e

;; Selecionar widget na tela (toque no app)
(pick!)

;; Ver contexto do widget selecionado
(keys *env)

;; Substituir widget selecionado
(mount! (m/Text "Novo widget!"))
```

### Nota

Para o dia-a-dia, o **hot reload é suficiente**. O REPL é um bônus para debugging e exploração.

---

## ⚡ Diferenças com Clojure

### O que é igual

- ✅ Estruturas imutáveis (maps, vectors, sets)
- ✅ Atoms para estado
- ✅ Funções de primeira classe
- ✅ Destructuring
- ✅ Threading macros (`->`, `->>`)
- ✅ Namespaces e require/refer

### O que é diferente

| Clojure | ClojureDart |
|---------|-------------|
| `(instance? Type x)` | `(dart/is? x Type)` |
| REPL nREPL | Socket REPL (beta) |
| `import` para classes | `require` com string URI |
| `defrecord` simples | Precisa de args extras: `(R. val nil {} -1)` |
| Multimethods completo | Parcial (sem hierarquias) |

### Imports

```clojure
;; Clojure
(:import [java.io File])

;; ClojureDart
(:require ["dart:io" :as io])
;; Usa: io/File
```

### try/catch com stacktrace

```clojure
;; Clojure: stacktrace attached
(try
  (throw (Exception. "erro"))
  (catch Exception e
    (println (.getMessage e))))

;; ClojureDart: stacktrace opcional
(try
  (throw (Exception "erro"))
  (catch Exception e st  ;; st = stacktrace opcional
    (println e)
    (println st)))
```

### Macros

Se sua macro usa funções auxiliares, marque-as:

```clojure
(defn ^:macro-support helper [x]
  (* x 2))

(defmacro my-macro [x]
  (helper x))
```

---

## 📚 Recursos e Próximos Passos

### Documentação

- [ClojureDart GitHub](https://github.com/Tensegritics/ClojureDart)
- [ClojureDart Cheatsheet (PDF)](https://github.com/Tensegritics/ClojureDart/blob/main/doc/ClojureDart%20Cheatsheet.pdf)
- [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)

### Vídeos

- [Conj 2023 - Demo do zero (recomendado!)](https://www.youtube.com/watch?v=wbUBb09bUnk)
- [Conj 2025 - REPL e melhorias](https://www.youtube.com/watch?v=ZLYnOTCRBbg)

### Comunidade

- [Slack #clojuredart](https://clojurians.slack.com/app_redirect?channel=clojuredart)
- [GitHub Issues](https://github.com/Tensegritics/ClojureDart/issues)

### Samples para Estudar

No repositório ClojureDart, pasta `samples/`:

| Sample | O que aprende |
|--------|---------------|
| `counter` | Estado básico com atoms |
| `fetch-data` | HTTP requests |
| `navigation` | Navegação push/pop |
| `form_validate` | Formulários e validação |
| `tabs` | TabBar e TabBarView |
| `drawer` | Menu lateral |
| `hero_animations` | Animações de transição |
| `bottom_navigation_bar` | Navegação inferior |

### Trilha de Estudo Sugerida

```
Semana 1-2: Flutter Básico
├── Conceito de Widgets
├── Layout (Column, Row, Container)
├── Botões e TextField
└── Roda samples: counter, navigation

Semana 3-4: Estado e Dados
├── Atoms e :watch
├── HTTP requests
├── Formulários
└── Roda samples: fetch-data, form_validate

Semana 5+: Projeto Próprio
├── Escolhe uma ideia simples
├── Implementa tela por tela
├── Adiciona navegação
└── Publica no device/emulador
```

---

## 🎉 Parabéns!

Você agora tem uma base sólida para começar com ClojureDart. Lembre-se:

1. **Não precisa decorar** — consulte este guia e a documentação
2. **Hot reload é seu amigo** — experimente, erre, aprenda
3. **Comunidade ajuda** — Slack #clojuredart é ativo e amigável
4. **Comece simples** — contador antes de app complexo

Bons estudos! 🚀
