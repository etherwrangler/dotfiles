local M = {}

local workspace_picker
local workspace_terminal
local workspace_active = false

local function terminal_options()
    return {
        cwd = vim.fn.getcwd(),
        env = {
            STARSHIP_CONFIG = vim.fn.stdpath("config") .. "/starship-nvim.toml",
        },
        win = {
            position = "right",
            width = 0.35,
            wo = {
                winbar = "",
            },
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

local function terminal(create)
    local options = terminal_options()
    options.create = create
    return require("snacks").terminal.get(nil, options)
end

local function focus(win)
    if win and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_set_current_win(win)
    end
end

local function hide_workspace()
    local picker = explorer()
    local main = picker and picker.main or vim.api.nvim_get_current_win()
    local right_terminal = workspace_terminal or terminal(false)

    if picker then
        picker:close()
        workspace_picker = nil
    end
    if right_terminal and right_terminal:win_valid() then
        right_terminal:hide()
    end
    workspace_active = false

    focus(main)
end

local function show_workspace()
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
    workspace_terminal = terminal(true)
    workspace_active = true

    if picker.shown then
        focus(picker.main or main)
        vim.cmd.stopinsert()
    end
end

function M.toggle()
    if workspace_active then
        hide_workspace()
    else
        show_workspace()
    end
end

function M.toggle_terminal()
    require("snacks").terminal.toggle(nil, terminal_options())
end

function M.setup()
    vim.api.nvim_create_user_command("IDEWorkspaceToggle", M.toggle, {
        desc = "Toggle the IDE workspace",
    })
    vim.api.nvim_create_user_command("IDEWorkspaceTerminalToggle", M.toggle_terminal, {
        desc = "Toggle the IDE workspace terminal",
    })
end

return M
