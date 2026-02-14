local map = vim.keymap.set
vim.g.mapleader = " "

--map("n", "<leader>pv", vim.cmd.Ex) -- i dont know what this is but it must be important!
--// Vanilla
map("n", "<C-n>", ":bnext<CR>", { desc = "Goto next buffer" })
map("n", "<C-p>", ":bprev<CR>", { desc = "Goto previous buffer" })
map("n", "<leader><space>", ":nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>w", ":w<CR>", { desc = "Write file" })
map("n", "<leader>q", ":q!<CR>", { desc = "Force quit" })
map({ "n", "x", "o" }, "<C-x>", "/\\s<CR>", { desc = "Jump to next space", silent = true })
map({ "n", "x", "o" }, "<C-a>", "?\\s<CR>", { desc = "Jump to previous space", silent = true })
map('n', 'mq', ':bd!<CR>', { desc = "Force delete buffer", silent = true })
map('i', '<C-y>', '<C-r>"', { desc = 'Yank last delete' })
map("n", "j", "gj", { buffer = true, noremap = true, silent = true })
map("n", "k", "gk", { buffer = true, noremap = true, silent = true })
map("v", "j", "gj", { buffer = true, noremap = true, silent = true })
map("v", "k", "gk", { buffer = true, noremap = true, silent = true })
map("n", "<C-j>", "o<Esc>", { desc = "Insert line below" })
map("n", "<C-k>", "O<Esc>", { desc = "Insert line above" })

--// LSP Related
map('n', '<leader>lr', vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ld", function() Snacks.picker.lsp_definitions() end, { desc = "Goto definition" })

map('n', '<leader>lgd', '<CMD>Glance definitions<CR>')
map('n', '<leader>lgr', '<CMD>Glance references<CR>')
map('n', '<leader>lgt', '<CMD>Glance type_definitions<CR>')
map('n', '<leader>lgi', '<CMD>Glance implementations<CR>')

map('n', '<leader>la', vim.lsp.buf.code_action, { desc = "Code action" })
map({ 'n', 'v' }, '<leader>lf', vim.lsp.buf.format, { desc = "Format document/range" })
map('n', '<leader>lh', vim.lsp.buf.hover, { desc = "Hover documentation" })
map('n', '<leader>li', vim.lsp.buf.implementation, { desc = "Goto implementation" })
map('n', '<leader>lw', function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Workspace symbols" })
map('n', '<leader>ll', function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
map('n', '<leader>l[', vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map('n', '<leader>l]', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map('n', '<leader>ld', vim.diagnostic.open_float, { desc = "Show diagnostics float" })

--// Folding
map('n', '<CR>', 'za', { desc = "Toggle fold" })

--// Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open oil / parent directory" })

--// Snacks Telescope
Snacks = Snacks;
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Open telescope" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Telescope buffers" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Telescope git files" })
map("n", "<leader>fi", function() Snacks.picker.git_log() end, { desc = "Telescope git" })
map("n", "<leader>f/", function() Snacks.picker.grep() end, { desc = "Telescope grep" })

--// Snacks Explorer
--map("n", "<leader>e", function() Snacks.explorer() end, { desc = "Open file explorer" })

