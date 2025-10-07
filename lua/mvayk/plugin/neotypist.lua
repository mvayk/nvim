return {
    "JohnnyJumper/neotypist.nvim",
    opts = {
        -- your configuration options here
    },
    config = function()
        require("neotypist").setup({
            -- Time in milliseconds between notifications (default: 60000)
            notify_interval = 60 * 1000,

            -- High WPM threshold for notification (default: 80)
            high = 120,

            -- Low WPM threshold for notification (default: 20)
            low = 5,

            -- Message to show when WPM is above high threshold
            high_message = "⚡️ You're a cheetah!",

            -- Message to show when WPM is below low threshold
            low_message = "🐢 Slowpoke!",

            -- Whether to show virtual text with WPM (default: true)
            show_virt_text = true,
            -- Whether to show notifications (default: true)
            notify = false,

            -- Time in milliseconds between WPM updates (default: 300)
            update_time = 300,

            -- Function that returns virtual text to display
            virt_text = function(wpm)
                return ("WPM: %.0f"):format(wpm)
            end,

            -- Position of virtual text (default: "right_align")
            virt_text_pos = "right_align",
        })
    end
}
