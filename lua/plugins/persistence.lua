if vim.g.neovide == true then
    vim.opt.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"

    local function real_buffers(exclude)
        local count = 0
        for _, b in ipairs(vim.api.nvim_list_bufs()) do
            if
                b ~= exclude
                and vim.bo[b].buflisted
                and vim.api.nvim_buf_is_loaded(b)
                and vim.bo[b].buftype == ""
                and vim.api.nvim_buf_get_name(b) ~= ""
            then
                count = count + 1
            end
        end
        return count
    end

    vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
        group = vim.api.nvim_create_augroup("back_to_dashboard", { clear = true }),
        callback = function(args)
            -- the buffer is still listed while this event fires, so exclude it
            vim.schedule(function()
                if vim.bo.filetype == "snacks_dashboard" then
                    return
                end
                if real_buffers(args.buf) > 0 then
                    return
                end
                -- close leftover splits so the dashboard gets a clean full window
                pcall(vim.cmd, "only")
                Snacks.dashboard()
            end)
        end,
    })

    return {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            -- add any custom options here
        },
        init = function()
            vim.api.nvim_create_autocmd("VimEnter", {
                nested = true,
                callback = function()
                    -- only restore when launched with no file args
                    if vim.fn.argc() > 0 or vim.g.started_with_stdin then
                        return
                    end
                    local persistence = require("persistence")
                    -- Neovide from a dock/launcher usually starts in ~, so there's no
                    -- project-specific session. Fall back to the last one used.
                    if vim.fn.getcwd() == vim.env.HOME then
                        persistence.load({ last = true })
                    else
                        persistence.load()
                    end
                end,
            })
        end,
    }
else
    return {}
end
