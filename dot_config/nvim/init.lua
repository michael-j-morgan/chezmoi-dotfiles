-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("toggleterm").setup({})
vim.wo.relativenumber = true
vim.api.nvim_set_hl(0, "LineNr", { fg = yellow })
