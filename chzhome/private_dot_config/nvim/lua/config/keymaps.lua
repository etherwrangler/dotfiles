local map = vim.keymap.set
local snacks = require("snacks")

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Write buffer" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic details" })

map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

map("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

map("n", "<leader><space>", snacks.picker.smart, { desc = "Smart find files" })
map("n", "<leader>e", function()
    snacks.explorer()
end, { desc = "File explorer" })
map("n", "<leader>/", snacks.picker.grep, { desc = "Grep project" })
map("n", "<leader>,", snacks.picker.buffers, { desc = "Find buffers" })
map("n", "<leader>fg", snacks.picker.git_files, { desc = "Find Git files" })
map("n", "<leader>gs", snacks.picker.git_status, { desc = "Git status" })
map("n", "<leader>gd", snacks.picker.git_diff, { desc = "Git diff" })
map("n", "<leader>gl", snacks.picker.git_log, { desc = "Git log" })

if vim.fn.executable("gh") == 1 then
    map("n", "<leader>gi", snacks.picker.gh_issue, { desc = "GitHub issues" })
    map("n", "<leader>gp", snacks.picker.gh_pr, { desc = "GitHub pull requests" })
end

map("x", "<", "<gv", { desc = "Indent left and reselect" })
map("x", ">", ">gv", { desc = "Indent right and reselect" })

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
