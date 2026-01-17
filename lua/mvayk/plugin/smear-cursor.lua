local enabled = true
if enabled then
    return {
        "https://github.com/sphamba/smear-cursor.nvim",
        opts = {
            smear_insert_mode = true,
            smear_between_buffers = true,
            smear_between_neighbour_lines = true,
            scroll_buffer_space = true,
            time_interval = 100,
        },
        config = function ()
            require("smear_cursor").setup({
                stiffness = 0.8,                      -- 0.6      [0, 1]
                trailing_stiffness = 0.6,             -- 0.45     [0, 1]
                stiffness_insert_mode = 0.9,          -- 0.5      [0, 1]
                trailing_stiffness_insert_mode = 0.2, -- 0.5      [0, 1]
                damping = 0.95,                       -- 0.85     [0, 1]
                damping_insert_mode = 0.95,           -- 0.9      [0, 1]
                distance_stop_animating = 0.5,        -- 0.1      > 0
            })
        end
    }
else
    return { }
end
