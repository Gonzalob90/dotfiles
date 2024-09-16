vim.g.loaded_netrw = 1
vim.opt.termguicolors = true
vim.g.loaded_netrwPlugin = 1
vim.g.nvim_tree_hide_dotfiles = 0

require("nvim-tree").setup({
  filters = {
    dotfiles = false,
    custom = {}
    }
  })

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
