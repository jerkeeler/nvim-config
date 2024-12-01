local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Smart way to move between windows
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-l>', '<C-W>l')

-- Smart way to resize windows
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")

-- New windows
map("n", "<leader>o", "<CMD>vsplit<CR>")
map("n", "<leader>p", "<CMD>split<CR>")

-- Hop to the file browser easily, "fd" for file directory
vim.keymap.set('n', '<Leader>fd', '<cmd>Ex<cr>')

-- Change buffers easily
vim.keymap.set('n', '<Leader>l', '<cmd>bnext<cr>')
vim.keymap.set('n', '<Leader>h', '<cmd>bprevious<cr>')

-- Quick scribble buffer
vim.keymap.set('n', '<Leader>q', '<cmd>e ~/buffer<cr>')

-- Toggle paste mode on/off
vim.keymap.set('n', '<Leader>pp', '<cmd>setlocal paste!<cr>')

-- Fast saving
vim.keymap.set('n', '<Leader>w', '<cmd>w!<cr>')


vim.keymap.set('n', '<Leader>x', '<cmd>close<cr>')


-- """"""""""""""""""""""""""""""
-- " => Visual mode related
-- """"""""""""""""""""""""""""""
-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
vim.keymap.set('v', '*', "<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>")
vim.keymap.set('v', '#', "<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>")
-- Disable highlight when <leader><cr> is pressed
vim.keymap.set('', '<Leader><cr>', '<cmd>noh<cr>')

-- Function to close the current buffer while handling alternate buffers
local function buf_close()
    local current_buf = vim.fn.bufnr('%')
    local alternate_buf = vim.fn.bufnr('#')

    -- Try to switch to alternate buffer if it exists
    if vim.fn.buflisted(alternate_buf) == 1 then
        vim.cmd('buffer #')
    else
        vim.cmd('bnext')
    end

    -- If we're still on the same buffer, create a new one
    if vim.fn.bufnr('%') == current_buf then
        vim.cmd('new')
    end

    -- Delete the original buffer if it's still listed
    if vim.fn.buflisted(current_buf) == 1 then
        vim.cmd('bdelete! ' .. current_buf)
    end
end

-- Create a user command to call the function
vim.api.nvim_create_user_command('Bclose', buf_close, {})
vim.keymap.set('n', '<Leader>bd', '<cmd>Bclose<cr>tabclose<cr>gT')
