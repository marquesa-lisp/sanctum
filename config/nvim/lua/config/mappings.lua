-- [nfnl] Compiled from fnl/config/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
vim.keymap.set("n", "<space>", "<nop>", {noremap = true})
vim.keymap.set("n", "<CR>", ":noh<CR><CR>", {noremap = true})
vim.keymap.set("n", "<C-w>T", ":tab split<CR>", {noremap = true, silent = true})
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", {noremap = true})
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", {noremap = false})
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", {noremap = false})
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", {noremap = false})
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", {noremap = false})
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", {noremap = false})
vim.keymap.set("n", "<leader>ll", ":bnext<CR>", {noremap = true})
vim.keymap.set("n", "<C-C-i>", ":bnext<CR>", {noremap = true})
vim.keymap.set("n", "<leader>hh", ":bprev<CR>", {noremap = true})
vim.keymap.set("n", "<leader>k", ":bdelete<CR>", {noremap = true})
local function clear_hidden_buffers()
  for _, buffer in pairs(vim.fn.getbufinfo()) do
    if (buffer.hidden == 1) then
      vim.cmd.bd(buffer.bufnr)
    else
    end
  end
  return nil
end
vim.keymap.set("n", "<Leader>bd", clear_hidden_buffers, {noremap = true, silent = false})

-- ============================================
-- Java keymaps
-- ============================================

-- Run Java project (compiles all and runs Main)
local function run_java_main()
  vim.cmd("write")
  local dir = vim.fn.expand("%:p:h")
  vim.cmd("!cd " .. dir .. " && javac *.java vo/*.java 2>/dev/null; javac *.java 2>/dev/null; java Main")
end
vim.keymap.set("n", "<Leader>rj", run_java_main, {noremap = true, silent = false, desc = "Run Java Main"})

-- Run current Java file (for simple single-file programs)
local function run_java_current()
  vim.cmd("write")
  local file = vim.fn.expand("%:t")
  local name = vim.fn.expand("%:t:r")
  local dir = vim.fn.expand("%:p:h")
  vim.cmd("!cd " .. dir .. " && javac " .. file .. " && java " .. name)
end
return vim.keymap.set("n", "<Leader>rJ", run_java_current, {noremap = true, silent = false, desc = "Run current Java file"})
