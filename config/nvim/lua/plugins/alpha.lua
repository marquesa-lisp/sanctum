-- [nfnl] fnl/plugins/alpha.fnl
local function _1_()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")
  dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  }
  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
    dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
    dashboard.button("g", "  Find text", ":Telescope live_grep<CR>"),
    dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
    dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
    dashboard.button("q", "  Quit", ":qa<CR>"),
  }
  dashboard.section.footer.val = {""}
  return alpha.setup(dashboard.config)
end
return {{"goolord/alpha-nvim", dependencies = {"nvim-tree/nvim-web-devicons"}, lazy = false, priority = 900, config = _1_}}

-- End of Fennel code
