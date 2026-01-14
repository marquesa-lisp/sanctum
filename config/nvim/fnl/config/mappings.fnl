;; space is reserved to be lead
(vim.keymap.set :n :<space> :<nop> {:noremap true})

;; clear highlighting on enter in normal mode
(vim.keymap.set :n :<CR> ":noh<CR><CR>" {:noremap true})

;; duplicate currents panel in a new tab
(vim.keymap.set :n :<C-w>T ":tab split<CR>" {:noremap true :silent true})

;; escape from terminal normal mode
(vim.keymap.set :t :<esc><esc> "<c-\\><c-n>" {:noremap true})

;; motions for windows
(vim.keymap.set :n :<c-k> ":wincmd k<CR>" {:noremap false})
(vim.keymap.set :n :<c-j> ":wincmd j<CR>" {:noremap false})
(vim.keymap.set :n :<c-h> ":wincmd h<CR>" {:noremap false})
(vim.keymap.set :n :<c-l> ":wincmd l<CR>" {:noremap false})
(vim.keymap.set :n :<leader>h ":nohlsearch<CR>" {:noremap false})

;; buffers navigation
(vim.keymap.set :n :<leader>ll ":bnext<CR>" {:noremap true})
(vim.keymap.set :n :<C-C-i>    ":bnext<CR>" {:noremap true})
(vim.keymap.set :n :<leader>hh ":bprev<CR>" {:noremap true})
(vim.keymap.set :n :<leader>k  ":bdelete<CR>" {:noremap true})

;; clear hidden buffers
(fn clear-hidden-buffers []
  (each [_ buffer (pairs (vim.fn.getbufinfo))]
    (when (= buffer.hidden 1) (vim.cmd.bd buffer.bufnr))))

(vim.keymap.set :n :<Leader>bd clear-hidden-buffers {:noremap true :silent false})

;; ============================================
;; Java keymaps
;; ============================================

;; Run Java project (compiles all and runs Main)
(fn run-java-main []
  (vim.cmd :write)
  (let [dir (vim.fn.expand "%:p:h")]
    (vim.cmd (.. "!cd " dir " && javac *.java vo/*.java 2>/dev/null; javac *.java 2>/dev/null; java Main"))))

(vim.keymap.set :n :<Leader>rj run-java-main {:noremap true :silent false :desc "Run Java Main"})

;; Run current Java file (for simple single-file programs)
(fn run-java-current []
  (vim.cmd :write)
  (let [file (vim.fn.expand "%:t")
        name (vim.fn.expand "%:t:r")
        dir (vim.fn.expand "%:p:h")]
    (vim.cmd (.. "!cd " dir " && javac " file " && java " name))))

(vim.keymap.set :n :<Leader>rJ run-java-current {:noremap true :silent false :desc "Run current Java file"})
