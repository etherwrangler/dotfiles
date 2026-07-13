local M = {}

local codex_command = { "codex" }
local workspace_picker
local workspace_terminal

local function codex_options()
    return {
        cwd = vim.fn.getcwd(),
        win = {
            position = "right",
            width = 0.35,
        },
    }
end

local function explorer()
    local active = require("snacks").picker.get({ source = "explorer" })[1]
    if active then
        return active
    end
    if workspace_picker and not workspace_picker.closed then
        return workspace_picker
    end
end

local function codex_terminal(create)
    local options = codex_options()
    options.create = create
    return require("snacks").terminal.get(codex_command, options)
end

local function focus(win)
    if win and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_set_current_win(win)
    end
end

local function hide_workspace()
    local picker = explorer()
    local main = picker and picker.main or vim.api.nvim_get_current_win()
    local terminal = workspace_terminal or codex_terminal(false)

    if picker then
        picker:close()
        workspace_picker = nil
    end
    if terminal and terminal:win_valid() then
        terminal:hide()
    end

    focus(main)
end

local function show_workspace()
    if vim.fn.executable(codex_command[1]) ~= 1 then
        vim.notify("The codex executable is not available in Neovim's PATH", vim.log.levels.ERROR)
        return
    end

    local main = vim.api.nvim_get_current_win()
    local picker = explorer()
    if not picker then
        picker = require("snacks").explorer({
            on_show = function(shown_picker)
                focus(shown_picker.main)
                vim.cmd.stopinsert()
            end,
        })
    end
    workspace_picker = picker
    workspace_terminal = codex_terminal(true)

    if picker.shown then
        focus(picker.main or main)
        vim.cmd.stopinsert()
    end
end

function M.toggle()
    local picker = explorer()
    local terminal = workspace_terminal or codex_terminal(false)
    local visible = picker ~= nil or (terminal and terminal:win_valid())

    if visible then
        hide_workspace()
    else
        show_workspace()
    end
end

function M.toggle_codex()
    if vim.fn.executable(codex_command[1]) ~= 1 then
        vim.notify("The codex executable is not available in Neovim's PATH", vim.log.levels.ERROR)
        return
    end

    require("snacks").terminal.toggle(codex_command, codex_options())
end

function M.setup()
    vim.api.nvim_create_user_command("IDEWorkspaceToggle", M.toggle, {
        desc = "Toggle the IDE workspace",
    })
    vim.api.nvim_create_user_command("CodexTerminalToggle", M.toggle_codex, {
        desc = "Toggle the Codex terminal",
    })
end

return M
