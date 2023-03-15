return {
  "junegunn/vim-easy-align",
  event = "BufEnter",
  config = function()
    local map = vim.keymap.set

    -- Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
    map("v", "<Enter>", "<Plug>(EasyAlign)", { silent = false })
    -- Start interactive EasyAlign in visual mode (e.g. vipga)
    map("x", "ga", "<Plug>(EasyAlign)", { silent = false })
    -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
    map("n", "ga", "<Plug>(EasyAlign)", { silent = false })
  end,
}
