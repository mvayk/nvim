local enabled = false

if enabled then
    return {
        'vyfor/cord.nvim',
        build = ':Cord update',
        -- opts = {}
    }
else
    return { }
end
