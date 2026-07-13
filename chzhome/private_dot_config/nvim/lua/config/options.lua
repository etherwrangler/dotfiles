-- Display
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.fillchars = { eob = " " }

-- Editing
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = -1
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Completion and command line
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.wildmode = { "longest:full", "full" }

-- Files and undo history
local undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undodir, "p")
vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.updatetime = 300

-- Interaction
vim.opt.timeoutlen = 500
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")

-- Windows and diffs
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.diffopt:append("linematch:60")
