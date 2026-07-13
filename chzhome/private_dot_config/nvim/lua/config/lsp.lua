vim.diagnostic.config({
    float = { border = "rounded", source = true },
    severity_sort = true,
    virtual_text = { source = "if_many", spacing = 2 },
})

local group = vim.api.nvim_create_augroup("config-lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    desc = "Configure language server features",
    callback = function(event)
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "<leader>lr", vim.lsp.buf.references, "Language server references")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Previous diagnostic")
        map("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Next diagnostic")

        if client:supports_method("textDocument/formatting") then
            map("n", "<leader>lf", function()
                vim.lsp.buf.format({ bufnr = event.buf })
            end, "Format buffer")
        end

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
            map("i", "<C-Space>", vim.lsp.completion.get, "Trigger completion")
        end
    end,
})

vim.lsp.enable({ "ansiblels", "yamlls" })
