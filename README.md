# Resistance Visuals

Visual enhancements for Neovim with Palestinian aesthetics, including tatreez borders, flag dividers, and revolutionary headers.

## 🌿 Features

- Palestinian tatreez (embroidery) borders for documents
- Poetic verses from Palestinian poets
- Palestinian flag dividers
- Cursor trails with Palestinian flag colors
- Palestinian-colored scrollbar
- Revolutionary headers for files

## 🚀 Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "alqattandev/resistance-visuals.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "rcarriga/nvim-notify",
    "MunifTanjim/nui.nvim",
  },
  config = true,
}
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  "alqattandev/resistance-visuals.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "rcarriga/nvim-notify",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("resistance-visuals").setup()
  end
}
```

## ⚙️ Configuration

```lua
require("resistance-visuals").setup({
  -- Palestinian flag colors
  colors = {
    red = "#CE1126",
    black = "#000000",
    white = "#FFFFFF",
    green = "#007A3D",
    gold = "#FFD700" -- For highlights
  },
  
  -- Tatreez (embroidery) patterns
  tatreez = {
    enabled = true,
    patterns = {
      "simple",
      "complex",
      "traditional",
    },
    default_pattern = "simple",
  },
  
  -- Cursor trail settings
  cursor_trail = {
    enabled = false, -- Disabled by default
    colors = { "#CE1126", "#000000", "#FFFFFF", "#007A3D" },
    length = 5,
    fade_speed = 0.1,
  },
  
  -- Scrollbar settings
  scrollbar = {
    enabled = false, -- Disabled by default
    colors = { "#CE1126", "#000000", "#FFFFFF", "#007A3D" },
  },
  
  -- Poetry settings
  poetry = {
    enabled = true,
    poets = {
      "Mahmoud Darwish",
      "Fadwa Tuqan",
      "Samih al-Qasim",
      "Tawfiq Zayyad",
      "Refaat Alareer",
    },
  },
})
```

## 🔑 Commands

- `:ResistanceTatreez` - Add tatreez border to current document
- `:ResistancePoetry` - Insert Palestinian poetry verse
- `:ResistanceFlagDivider` - Insert flag divider
- `:ResistanceCursorTrail` - Toggle Palestinian cursor trail
- `:ResistanceScrollbar` - Toggle resistance scrollbar
- `:ResistanceHeader` - Add resistance header to file
- `:OliveBranchCursor` - Toggle olive branch cursor

## ⌨️ Keymaps

No default keymaps are provided. Here are some suggested mappings:

```lua
vim.keymap.set("n", "<leader>rvt", require("resistance-visuals").add_tatreez_border, { desc = "Add Tatreez Border" })
vim.keymap.set("n", "<leader>rvf", require("resistance-visuals").insert_flag_divider, { desc = "Insert Flag Divider" })
vim.keymap.set("n", "<leader>rvp", require("resistance-visuals").insert_poetry, { desc = "Insert Palestinian Poetry" })
vim.keymap.set("n", "<leader>rvc", require("resistance-visuals").toggle_cursor_trail, { desc = "Toggle Cursor Trail" })
vim.keymap.set("n", "<leader>rvs", require("resistance-visuals").toggle_resistance_scrollbar, { desc = "Toggle Resistance Scrollbar" })
vim.keymap.set("n", "<leader>rvh", require("resistance-visuals").resistance_header, { desc = "Insert Resistance Header" })
vim.keymap.set("n", "<leader>rvo", require("resistance-visuals").olive_branch_cursor, { desc = "Olive Branch Cursor" })
```

## 🌱 Philosophy

This plugin brings Palestinian aesthetics into your coding environment, serving as a visual reminder of solidarity and resistance. The traditional tatreez patterns and poetry connect your modern coding practice with centuries of Palestinian cultural heritage.

## 📜 License

MIT