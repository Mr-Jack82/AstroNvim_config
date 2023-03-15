return {
  "phaazon/hop.nvim",
  branch = "v2",
  keys = { "s", "f", "F", "T", "t" },
  init = function()
    local hop = require("hop")
    hop.setup {
      uppercase_labels = true,
      keys = "etovxqpdygfblzhckisuran",
    }

    local directions = require("hop.hint").HintDirection

    local map = vim.keymap.set

    map("n", "s", "<cmd>HopChar1<CR>", { noremap = false, silent = false })
    map({ "n", "v" }, "<leader>/", "<cmd>HopPattern<CR>", { silent = false })
    map({ "n", "v", "o" }, "f", "<cmd>HopChar1CurrentLineAC<CR>", { silent = false })
    map({ "n", "v", "o" }, "F", "<cmd>HopChar1CurrentLineBC<CR>", { silent = false })
    map("o", "z", "<cmd>HopChar1<CR>", { silent = false })
    map("", "t", function ()
      hop.hint_char1({
          direction = directions.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
    end, { remap = true })
    map("", "T", function()
      hop.hint_char1({
          direction = directions.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = 1,
        })
    end, { remap = true })
  end,
}
