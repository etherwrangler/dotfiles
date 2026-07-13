local function yaml_filetype(path)
    if vim.fs.root(path, { "ansible.cfg", ".ansible-lint" }) then
        return "yaml.ansible"
    end

    return "yaml"
end

vim.filetype.add({
    extension = {
        yaml = yaml_filetype,
        yml = yaml_filetype,
    },
    pattern = {
        [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
        [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
        [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/defaults/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/meta/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/vars/.*%.ya?ml"] = "yaml.ansible",
        [".*%.ansible%.ya?ml"] = "yaml.ansible",
    },
})
