local group = vim.api.nvim_create_augroup("config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    desc = "Highlight copied text",
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    desc = "Restore the last cursor position",
    callback = function(event)
        local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(event.buf)

        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = group,
    desc = "Check for files changed outside Neovim",
    command = "checktime",
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Make prose easier to read",
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.colorcolumn = ""
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Close temporary buffers with q",
    pattern = { "checkhealth", "help", "lspinfo", "man", "qf" },
    callback = function(event)
        vim.keymap.set("n", "q", "<cmd>close<CR>", {
            buffer = event.buf,
            desc = "Close window",
            silent = true,
        })
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    desc = "Hide editor columns in terminals",
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})
