local function use_matugen()
    local config

    if require("settings").use_matugen then
        config = function()
            local ok, matugen = pcall(require, "matugen")
            if ok then
                matugen.setup()
            end
        end
    end

    return config
end

return {
    "RRethy/base16-nvim",
    config = function()
        use_matugen()
    end,
}
