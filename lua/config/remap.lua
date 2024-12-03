local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Smart way to move between windows
map("n", "<C-j>", "<C-W>j")
map("n", "<C-k>", "x<C-W>k")
map("n", "<C-h>", "<C-W>h")
map("n", "<C-l>", "<C-W>l")

-- Smart way to resize windows
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")

-- New windows
map("n", "<leader>o", "<CMD>vsplit<CR>")
map("n", "<leader>p", "<CMD>split<CR>")

-- Hop to the basic file browser easily, "fd" for file directory
map("n", "<Leader>fd", "<cmd>Ex<cr>")

-- Change buffers easily
map("n", "<Leader>l", "<cmd>bnext<cr>")
map("n", "<Leader>h", "<cmd>bprevious<cr>")

-- Quick scribble buffer
map("n", "<Leader>q", "<cmd>e ~/buffer<cr>")

-- Toggle paste mode on/off
map("n", "<Leader>pp", "<cmd>setlocal paste!<cr>")

-- Fast saving
map("n", "<Leader>w", "<cmd>w!<cr>")

-- Fast closing
map("n", "<Leader>x", "<cmd>close<cr>")

-- """"""""""""""""""""""""""""""
-- " => Visual mode related
-- """"""""""""""""""""""""""""""
-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
map("v", "*", "<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>")
map("v", "#", "<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>")
-- Disable highlight when <leader><cr> is pressed
map("", "<Leader><cr>", "<cmd>noh<cr>")

-- """"""""""""""""""""""""""""""
-- " Telescope remaps
-- """"""""""""""""""""""""""""""
-- Function to close the current buffer while handling alternate buffers
local function buf_close()
	local current_buf = vim.fn.bufnr("%")
	local alternate_buf = vim.fn.bufnr("#")

	-- Try to switch to alternate buffer if it exists
	if vim.fn.buflisted(alternate_buf) == 1 then
		vim.cmd("buffer #")
	else
		vim.cmd("bnext")
	end

	-- If we're still on the same buffer, create a new one
	if vim.fn.bufnr("%") == current_buf then
		vim.cmd("new")
	end

	-- Delete the original buffer if it's still listed
	if vim.fn.buflisted(current_buf) == 1 then
		vim.cmd("bdelete! " .. current_buf)
	end
end
-- Create a user command to call the function
vim.api.nvim_create_user_command("Bclose", buf_close, {})
map("n", "<Leader>bd", "<cmd>Bclose<cr>tabclose<cr>gT")

-- """"""""""""""""""""""""""""""
-- DEPRECATED, using fzf-lua instead for performance
-- " Telescope remaps
-- """"""""""""""""""""""""""""""
-- map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
-- map("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find files in buffers" })
-- map("n", "<leader>fi", function()
-- 	require("telescope.builtin").find_files({ no_ignore = true, hidden = true })
-- end, { desc = "Find files (including ignored)" })
-- map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")

-- """"""""""""""""""""""""""""""
-- " Neotree remaps
-- """"""""""""""""""""""""""""""
map("n", "<leader>f", "<cmd>FzfLua files<cr>")
map("n", "<leader>b", "<cmd>FzfLua buffers<cr>")
map("n", "<leader>g", "<cmd>FzfLua live_grep<cr>")
map("n", "<leader>fg", "<cmd>FzfLua git_files<cr>")

-- """"""""""""""""""""""""""""""
-- " Neotree remaps
-- """"""""""""""""""""""""""""""
map("n", "<leader>n", "<cmd>Neotree<cr>")
map("n", "<leader>nc", "<cmd>Neotree position=current<cr>")
map("n", "<leader>ng", "<cmd>Neotree float git_status<cr>")

-- """"""""""""""""""""""""""""""
-- " Undotree remaps
-- """"""""""""""""""""""""""""""
map("n", "<leader>ut", "<cmd>UndotreeToggle<cr>")

-- Basic LSP keybindings for definitions
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
