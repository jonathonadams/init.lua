vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)       -- ::

-- move highlighted line up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in moving line up
vim.keymap.set("n", "J", "mzJ`z")

-- keep screen centered when half screen scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- when searching, keeps highlighted term term in centre of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- When pasting over something, won't loose original yank 
vim.keymap.set("x", "<leader>p", [["_dP]])

-- leader y/p will copy/delete to system clipboard
vim.keymap.set({"n", "x"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "x"}, "<leader>d", [["_d]])


-- vim.keymap.set("n", "Q", "<nop>")
--
-- Quick navigation to new project (via tmux)
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quick Fix list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- leader s, replace all occurrences of the word your on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- leaders x -> set executable file permissions on a file (i.e. bash script)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
