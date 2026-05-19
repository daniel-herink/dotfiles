vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

-- Use OSC 52 for clipboard so yank/paste work over SSH+tmux without an X
-- server. Avoids "Can't open display" errors when DISPLAY is stale or absent.
-- Requires Neovim 0.10+ and a terminal that supports OSC 52 (MinTTY does).
vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
        ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
}

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.scrolloff = 8
vim.opt.termguicolors = true

vim.cmd.colorscheme('habamax')
