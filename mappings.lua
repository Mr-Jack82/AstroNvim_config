-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
    ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
    ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["J"] = { "mzJ`z", desc = "Join lines in place" },
    ["U"] = { "<C-r>", desc = "Redo" },
    ["db"] = { 'vb"_d', desc = "Delete" },
    ["<leader>L"] = { "<cmd>:Lazy<cr>", desc = "Lazy" },
    -- quick save
    ["<leader>,"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", desc = "Move text" },
    ["K"] = { ":m '<-2<CR>gv=gv", desc = "Move text" },
  },
  x = {
    ["<leader>p"] = { [["_dP"]], desc = "Delete" },
  },
  i = {
    ["<C-h>"] = { "<Left>", desc = "Move left" },
    ["<C-l>"] = { "<Right>", desc = "Move right" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
