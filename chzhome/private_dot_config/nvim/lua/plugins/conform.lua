require("conform").setup({
    formatters_by_ft = {
        ["yaml.ansible"] = { "ansible-lint" },
    },
    default_format_opts = {
        lsp_format = "fallback",
        timeout_ms = 5000,
    },
    formatters = {
        ["ansible-lint"] = {
            args = { "-f", "codeclimate", "-q", "--fix=none", "$FILENAME" },
            exit_codes = { 0, 2, 8 },
        },
    },
})
