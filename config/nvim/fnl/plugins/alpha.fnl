[{1 :goolord/alpha-nvim
  :dependencies [:nvim-tree/nvim-web-devicons]
  :lazy false
  :priority 900
  :config (fn []
            (let [alpha (require :alpha)
                  dashboard (require :alpha.themes.dashboard)]
              ;; Header
              (set dashboard.section.header.val
                   ["                                                     "
                    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ "
                    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ "
                    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ "
                    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ "
                    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ "
                    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ "
                    "                                                     "])
              ;; Buttons
              (set dashboard.section.buttons.val
                   [(dashboard.button "f" "  Find file" ":Telescope find_files<CR>")
                    (dashboard.button "r" "  Recent files" ":Telescope oldfiles<CR>")
                    (dashboard.button "g" "  Find text" ":Telescope live_grep<CR>")
                    (dashboard.button "n" "  New file" ":ene <BAR> startinsert<CR>")
                    (dashboard.button "c" "  Configuration" ":e ~/.config/nvim/init.lua<CR>")
                    (dashboard.button "q" "  Quit" ":qa<CR>")])
              ;; Footer
              (set dashboard.section.footer.val [""])
              ;; Setup
              (alpha.setup dashboard.config)))}]
