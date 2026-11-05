local icon_package = require("settings").icon_theme_package

if not icon_package then
    return {}
end

return {
    icon_package.git,
    lazy = false,
    priority = 1000,
    config = function()
        icon_package:setup()
    end,
}
