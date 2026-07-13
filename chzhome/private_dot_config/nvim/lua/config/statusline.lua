local M = {}

local branch = ""
local branch_request = 0

local modes = {
    n = { "NORMAL", "StatusLineModeNormal" },
    i = { "INSERT", "StatusLineModeInsert" },
    v = { "VISUAL", "StatusLineModeVisual" },
    V = { "V-LINE", "StatusLineModeVisual" },
    ["\22"] = { "V-BLOCK", "StatusLineModeVisual" },
    R = { "REPLACE", "StatusLineModeReplace" },
    c = { "COMMAND", "StatusLineModeCommand" },
    s = { "SELECT", "StatusLineModeVisual" },
    S = { "S-LINE", "StatusLineModeVisual" },
    t = { "TERMINAL", "StatusLineModeTerminal" },
}

local function escape(value)
    return value:gsub("%%", "%%%%")
end

local function set_branch(value, request)
    vim.schedule(function()
        if request ~= branch_request then
            return
        end
        branch = vim.trim(value or "")
        vim.cmd.redrawstatus()
    end)
end

local function branch_cwd()
    local name = vim.api.nvim_buf_get_name(0)
    if name ~= "" and vim.bo.buftype == "" then
        return vim.fs.dirname(name)
    end
    return vim.fn.getcwd()
end

function M.refresh_branch()
    branch_request = branch_request + 1
    local request = branch_request

    if vim.fn.executable("git") ~= 1 then
        set_branch("", request)
        return
    end

    local cwd = branch_cwd()
    vim.system({ "git", "-C", cwd, "symbolic-ref", "--quiet", "--short", "HEAD" }, { text = true }, function(result)
        if result.code == 0 then
            set_branch(result.stdout, request)
            return
        end

        vim.system({ "git", "-C", cwd, "rev-parse", "--short", "HEAD" }, { text = true }, function(fallback)
            set_branch(fallback.code == 0 and fallback.stdout or "", request)
        end)
    end)
end

local function buffer_label()
    if vim.bo.buftype == "terminal" then
        return "Terminal"
    end
    if vim.bo.filetype:match("^snacks_picker") then
        return "Explorer"
    end

    local name = vim.api.nvim_buf_get_name(0)
    return name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":t")
end

local function diagnostics()
    local counts = vim.diagnostic.count(0)
    local errors = counts[vim.diagnostic.severity.ERROR] or 0
    local warnings = counts[vim.diagnostic.severity.WARN] or 0
    local parts = {}

    if errors > 0 then
        parts[#parts + 1] = "%#StatusLineDiagnosticError#E:" .. errors
    end
    if warnings > 0 then
        parts[#parts + 1] = "%#StatusLineDiagnosticWarn#W:" .. warnings
    end

    return table.concat(parts, " ")
end

function M.render()
    local mode = modes[vim.fn.mode(1):sub(1, 1)] or { "UNKNOWN", "StatusLineModeNormal" }
    local modified = vim.bo.modified and " [+]" or ""
    local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "text"
    local diagnostic_status = diagnostics()

    local sections = {
        "%#" .. mode[2] .. "# " .. mode[1] .. " ",
        "%#StatusLineFile# " .. escape(buffer_label()) .. modified .. " %<",
    }

    if branch ~= "" then
        sections[#sections + 1] = "%#StatusLineBranch#  " .. escape(branch) .. " "
    end

    sections[#sections + 1] = "%="
    if diagnostic_status ~= "" then
        sections[#sections + 1] = diagnostic_status .. "  "
    end
    sections[#sections + 1] = "%#StatusLineMuted#" .. escape(filetype) .. "  %l:%c  %p%% "

    return table.concat(sections)
end

local function setup_highlights()
    local colors = require("catppuccin.palettes").get_palette()
    local highlights = {
        StatusLine = { fg = colors.text, bg = colors.mantle },
        StatusLineFile = { fg = colors.text, bg = colors.mantle },
        StatusLineBranch = { fg = colors.lavender, bg = colors.mantle, bold = true },
        StatusLineMuted = { fg = colors.subtext0, bg = colors.mantle },
        StatusLineDiagnosticError = { fg = colors.red, bg = colors.mantle, bold = true },
        StatusLineDiagnosticWarn = { fg = colors.yellow, bg = colors.mantle, bold = true },
        StatusLineModeNormal = { fg = colors.crust, bg = colors.blue, bold = true },
        StatusLineModeInsert = { fg = colors.crust, bg = colors.green, bold = true },
        StatusLineModeVisual = { fg = colors.crust, bg = colors.mauve, bold = true },
        StatusLineModeReplace = { fg = colors.crust, bg = colors.red, bold = true },
        StatusLineModeCommand = { fg = colors.crust, bg = colors.peach, bold = true },
        StatusLineModeTerminal = { fg = colors.crust, bg = colors.teal, bold = true },
    }

    for name, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, name, opts)
    end
end

function M.setup()
    setup_highlights()
    vim.o.laststatus = 3
    vim.o.statusline = "%!v:lua.ConfigStatusline()"
    _G.ConfigStatusline = M.render

    local group = vim.api.nvim_create_augroup("config-statusline", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged", "FocusGained", "ShellCmdPost", "TermLeave" }, {
        group = group,
        callback = M.refresh_branch,
    })
    vim.api.nvim_create_autocmd({ "DiagnosticChanged", "ModeChanged", "WinEnter", "WinLeave" }, {
        group = group,
        callback = function()
            vim.cmd.redrawstatus()
        end,
    })

    vim.schedule(M.refresh_branch)
end

return M
