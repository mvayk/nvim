local map = vim.keymap.set

vim.g.mapleader = " "
-- map("n", "<leader>pv", vim.cmd.Ex)
map("n", "<C-n>", ":bnext<CR>")
map("n", "<C-p>", ":bprev<CR>")
map('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader><space>", ":nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>w", ":w<CR>", { desc = "Write file using leader" })

--> emacs bindings for insert mode
map('i', '<C-a>', '<Home>', {desc='Move to start of line'})      -- C-a
map('i', '<C-e>', '<End>',  {desc='Move to end of line'})        -- C-e
map('i', '<M-b>', '<C-o>b', {desc='Back word'})                  -- M-b
map('i', '<M-f>', '<C-o>w', {desc='Forward word'})               -- M-f

map('i', '<M-h>', '<C-o>h', { desc = 'Move left' })
map('i', '<M-j>', '<C-o>j', { desc = 'Move down' })
map('i', '<M-k>', '<C-o>k', { desc = 'Move up' })
map('i', '<M-l>', '<C-o>l', { desc = 'Move right' })

map('i', '<C-d>', '<Del>',  {desc='Delete char under cursor'})   -- C-d
map('i', '<M-d>', '<C-o>dw',{desc='Kill word forward'})          -- M-d
map('i', '<C-k>', '<C-o>D', {desc='Kill to end of line'})        -- C-k

map('i', '<C-_>', '<C-o>u', {desc='Undo'})                      -- C-_
map('i', '<M-_>', '<C-o><C-r>', {desc='Redo'})                  -- M-_

map('i', '<C-y>', '<C-r>"', {desc='Yank last delete'})          -- C-y
