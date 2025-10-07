local plugins = {}

local plugin_path = vim.fn.stdpath("config") .. "/lua/mvayk/plugin"

local uv = vim.loop
local handle = uv.fs_scandir(plugin_path)

if handle then
    while true do
        local name, type = uv.fs_scandir_next(handle)
        if not name then break end
        if type == "file" and name:match("%.lua$") and name ~= "init.lua" then
            local mod_name = name:gsub("%.lua$", "")
            local ok, plugin = pcall(require, "mvayk.plugin." .. mod_name)
            if ok and plugin then
                vim.list_extend(plugins, plugin)
            else
                vim.notify("Failed to load plugin module: " .. mod_name, vim.log.levels.WARN)
            end
        end
    end
end

return plugins
