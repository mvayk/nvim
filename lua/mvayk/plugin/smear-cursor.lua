return {
    "https://github.com/sphamba/smear-cursor.nvim",
    opts = {
        smear_insert_mode = true,
        smear_between_buffers = true,
        smear_between_neighbour_lines = true,
        scroll_buffer_space = false,
        time_interval = 100,
    },
    config = function ()
        require("smear_cursor").setup({
            stiffness = 0.5,
            trailing_stiffness = 0.49,
            never_draw_over_target = false,
        })
    end
}
