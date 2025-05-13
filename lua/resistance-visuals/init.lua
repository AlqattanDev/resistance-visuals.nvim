-- Resistance Visuals
-- Visual enhancements for Neovim with Palestinian aesthetics

local api = vim.api
local notify = require("notify")
local nui_popup = require("nui.popup")

-- Create the namespace
local visuals = {}

-- Default configuration
local default_config = {
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
}

-- Plugin configuration
local config = {}

-- Tatreez patterns
local tatreez_patterns = {
  simple = {
    "╭" .. string.rep("─", 60) .. "╮",
    "│ 🇵🇸 ✧･ﾟ: *✧･ﾟ:* 🌿 PALESTINIAN TATREEZ 🌿 *:･ﾟ✧*:･ﾟ✧ 🇵🇸 │",
    "│" .. string.rep(" ", 60) .. "│",
    "│" .. string.rep("╱╲", 15) .. "│",
    "│" .. string.rep("╲╱", 15) .. "│",
    "│" .. string.rep(" ", 60) .. "│",
    "╰" .. string.rep("─", 60) .. "╯",
  },
  
  complex = {
    "╭" .. string.rep("─", 60) .. "╮",
    "│ 🇵🇸 ✧･ﾟ: *✧･ﾟ:* 🌿 PALESTINIAN TATREEZ 🌿 *:･ﾟ✧*:･ﾟ✧ 🇵🇸 │",
    "│" .. string.rep(" ", 60) .. "│",
    "│  " .. string.rep("▚▞", 14) .. "  │",
    "│  " .. string.rep("▞▚", 14) .. "  │",
    "│  " .. string.rep("▚▞", 14) .. "  │",
    "│  " .. string.rep("▞▚", 14) .. "  │",
    "│" .. string.rep(" ", 60) .. "│",
    "╰" .. string.rep("─", 60) .. "╯",
  },
  
  traditional = {
    "╭" .. string.rep("─", 60) .. "╮",
    "│ 🇵🇸 ✧･ﾟ: *✧･ﾟ:* 🌿 PALESTINIAN TATREEZ 🌿 *:･ﾟ✧*:･ﾟ✧ 🇵🇸 │",
    "│" .. string.rep(" ", 60) .. "│",
    "│  " .. string.rep("🔴⚫⚪🟢", 7) .. "  │",
    "│  " .. string.rep("🟢⚪⚫🔴", 7) .. "  │",
    "│  " .. string.rep("🔴⚫⚪🟢", 7) .. "  │",
    "│  " .. string.rep("🟢⚪⚫🔴", 7) .. "  │",
    "│" .. string.rep(" ", 60) .. "│",
    "╰" .. string.rep("─", 60) .. "╯",
  },
}

-- Poetry collection
local poetry_collection = {
  ["Mahmoud Darwish"] = {
    {
      title = "In Jerusalem",
      lines = {
        "In Jerusalem, and I mean within the ancient walls,",
        "I walk from one epoch to another without a memory",
        "to guide me. The prophets over there are sharing",
        "the history of the holy... ascending to heaven",
        "and returning less discouraged and melancholy, because love",
        "and peace are holy and are coming to town.",
      },
    },
    {
      title = "I Come From There",
      lines = {
        "I come from there and I have memories",
        "Born as mortals are, I have a mother",
        "And a house with many windows,",
        "I have brothers, friends,",
        "And a prison cell with a cold window.",
      },
    },
    {
      title = "We Travel Like Other People",
      lines = {
        "We travel like other people, but we return to nowhere.",
        "As if traveling is the way of the clouds.",
        "We have buried our loved ones in the darkness of the clouds,",
        "between the roots of trees.",
      },
    },
  },
  
  ["Fadwa Tuqan"] = {
    {
      title = "Enough for Me",
      lines = {
        "Enough for me to die on her earth",
        "Be buried in her",
        "To melt and vanish into her soil",
        "Then sprout forth as a flower",
        "Played with by a child from my country.",
      },
    },
  },
  
  ["Samih al-Qasim"] = {
    {
      title = "End of a Talk with a Jailer",
      lines = {
        "From the window of my small cell",
        "I can see trees smiling at me,",
        "giving me their blessing.",
        "I can see you, too.",
        "And I know that we shall meet",
        "behind the veil of freedom.",
      },
    },
  },
  
  ["Tawfiq Zayyad"] = {
    {
      title = "Here We Shall Stay",
      lines = {
        "In Lydda, in Ramla, in the Galilee,",
        "we shall remain",
        "like a wall upon your chest,",
        "and in your throat",
        "like a shard of glass,",
        "a cactus thorn,",
        "and in your eyes",
        "a sandstorm.",
      },
    },
  },
  
  ["Refaat Alareer"] = {
    {
      title = "If I Must Die",
      lines = {
        "If I must die,",
        "you must live",
        "to tell my story",
        "to sell my things",
        "to buy a piece of cloth",
        "and some strings",
        "(make it white with a long tail)",
        "so that a child, somewhere in Gaza",
        "while looking heaven in the eye",
        "awaiting his dad who left in a blaze—",
        "and bid no one farewell",
        "not even to his flesh",
        "not even to himself—",
        "sees the kite, my kite you made, flying up",
        "and thinks for a moment an angel is there",
        "bringing back love",
        "If I must die",
        "let it bring hope",
        "let it be a tale",
      },
    },
  },
}

-- Flag divider patterns
local flag_dividers = {
  simple = "🇵🇸 " .. string.rep("━", 50) .. " 🇵🇸",
  complex = "🇵🇸 " .. string.rep("━", 10) .. " ✊ " .. string.rep("━", 10) .. " 🌿 " .. string.rep("━", 10) .. " 🗝️ " .. string.rep("━", 10) .. " 🇵🇸",
  minimal = "🇵🇸━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━🇵🇸",
}

-- Cursor trail state
local cursor_trail = {
  enabled = false,
  positions = {},
  namespace = api.nvim_create_namespace("resistance_cursor_trail"),
  timer = nil,
}

-- Scrollbar state
local scrollbar = {
  enabled = false,
  namespace = api.nvim_create_namespace("resistance_scrollbar"),
  timer = nil,
}

-- Add tatreez border to current document
function visuals.add_tatreez_border()
  local pattern = config.tatreez.default_pattern
  local tatreez = tatreez_patterns[pattern]
  
  if not tatreez then
    notify("Tatreez pattern not found: " .. pattern, vim.log.levels.ERROR, {
      title = "Resistance Visuals",
    })
    return
  end
  
  -- Get current buffer
  local bufnr = api.nvim_get_current_buf()
  
  -- Insert tatreez at the beginning of the buffer
  api.nvim_buf_set_lines(bufnr, 0, 0, false, tatreez)
  
  -- Insert tatreez at the end of the buffer
  local line_count = api.nvim_buf_line_count(bufnr)
  api.nvim_buf_set_lines(bufnr, line_count, line_count, false, tatreez)
  
  notify("🌿 Added " .. pattern .. " tatreez border", vim.log.levels.INFO, {
    title = "Resistance Visuals",
    timeout = 3000,
  })
end

-- Insert flag divider
function visuals.insert_flag_divider()
  -- Get current buffer and cursor position
  local bufnr = api.nvim_get_current_buf()
  local row, _ = unpack(api.nvim_win_get_cursor(0))
  
  -- Insert flag divider at cursor position
  api.nvim_buf_set_lines(bufnr, row, row, false, { flag_dividers.simple })
  
  notify("🇵🇸 Inserted flag divider", vim.log.levels.INFO, {
    title = "Resistance Visuals",
    timeout = 3000,
  })
end

-- Insert Palestinian poetry
function visuals.insert_poetry()
  -- Create menu with poets
  local menu_items = {}
  for poet, _ in pairs(poetry_collection) do
    table.insert(menu_items, nui_popup.menu_item(poet))
  end
  
  local poet_menu = nui_popup.menu({
    position = "50%",
    size = {
      width = 40,
      height = #menu_items + 2,
    },
    border = {
      style = "rounded",
      text = {
        top = " 🇵🇸 Palestinian Poets ",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal",
    },
  }, {
    lines = menu_items,
    max_width = 40,
    keymap = {
      focus_next = { "j", "<Down>" },
      focus_prev = { "k", "<Up>" },
      close = { "<Esc>", "<C-c>" },
      submit = { "<CR>" },
    },
    on_submit = function(poet)
      -- Get poems by selected poet
      local poems = poetry_collection[poet]
      
      -- Create menu with poems
      local poem_items = {}
      for _, poem in ipairs(poems) do
        table.insert(poem_items, nui_popup.menu_item(poem.title))
      end
      
      local poem_menu = nui_popup.menu({
        position = "50%",
        size = {
          width = 50,
          height = #poem_items + 2,
        },
        border = {
          style = "rounded",
          text = {
            top = " Poems by " .. poet .. " ",
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal",
        },
      }, {
        lines = poem_items,
        max_width = 50,
        keymap = {
          focus_next = { "j", "<Down>" },
          focus_prev = { "k", "<Up>" },
          close = { "<Esc>", "<C-c>" },
          submit = { "<CR>" },
        },
        on_submit = function(title)
          -- Find selected poem
          local selected_poem = nil
          for _, poem in ipairs(poems) do
            if poem.title == title then
              selected_poem = poem
              break
            end
          end
          
          if selected_poem then
            -- Get current buffer and cursor position
            local bufnr = api.nvim_get_current_buf()
            local row, _ = unpack(api.nvim_win_get_cursor(0))
            
            -- Prepare poem lines
            local poem_lines = {
              "/* " .. selected_poem.title .. " - " .. poet .. " */",
              "/*",
            }
            
            for _, line in ipairs(selected_poem.lines) do
              table.insert(poem_lines, " * " .. line)
            end
            
            table.insert(poem_lines, " */")
            
            -- Insert poem at cursor position
            api.nvim_buf_set_lines(bufnr, row, row, false, poem_lines)
            
            notify("📜 Inserted poem: " .. selected_poem.title .. " by " .. poet, vim.log.levels.INFO, {
              title = "Resistance Visuals",
              timeout = 3000,
            })
          end
        end,
      })
      
      poem_menu:mount()
    end,
  })
  
  poet_menu:mount()
end

-- Toggle cursor trail
function visuals.toggle_cursor_trail()
  cursor_trail.enabled = not cursor_trail.enabled
  
  if cursor_trail.enabled then
    -- Start cursor trail
    if cursor_trail.timer then
      cursor_trail.timer:stop()
    end
    
    cursor_trail.positions = {}
    
    -- Create autocmd to track cursor position
    api.nvim_create_autocmd("CursorMoved", {
      callback = function()
        local win = api.nvim_get_current_win()
        local pos = api.nvim_win_get_cursor(win)
        
        table.insert(cursor_trail.positions, 1, {
          line = pos[1] - 1,
          col = pos[2],
          color = config.cursor_trail.colors[math.random(#config.cursor_trail.colors)],
          alpha = 1.0,
        })
        
        -- Limit trail length
        if #cursor_trail.positions > config.cursor_trail.length then
          table.remove(cursor_trail.positions)
        end
        
        -- Clear previous trail
        api.nvim_buf_clear_namespace(0, cursor_trail.namespace, 0, -1)
        
        -- Draw trail
        for i, pos in ipairs(cursor_trail.positions) do
          local color = pos.color
          local alpha = pos.alpha * (1 - (i / #cursor_trail.positions))
          
          api.nvim_buf_set_extmark(0, cursor_trail.namespace, pos.line, pos.col, {
            virt_text = { { "•", color } },
            virt_text_pos = "overlay",
            priority = 100,
          })
          
          pos.alpha = pos.alpha - config.cursor_trail.fade_speed
        end
      end,
    })
    
    notify("🇵🇸 Enabled Palestinian cursor trail", vim.log.levels.INFO, {
      title = "Resistance Visuals",
      timeout = 3000,
    })
  else
    -- Stop cursor trail
    if cursor_trail.timer then
      cursor_trail.timer:stop()
      cursor_trail.timer = nil
    end
    
    -- Clear trail
    api.nvim_buf_clear_namespace(0, cursor_trail.namespace, 0, -1)
    
    notify("Disabled cursor trail", vim.log.levels.INFO, {
      title = "Resistance Visuals",
      timeout = 3000,
    })
  end
end

-- Toggle resistance scrollbar
function visuals.toggle_resistance_scrollbar()
  scrollbar.enabled = not scrollbar.enabled
  
  if scrollbar.enabled then
    -- Start scrollbar
    if scrollbar.timer then
      scrollbar.timer:stop()
    end
    
    -- Create autocmd to update scrollbar
    api.nvim_create_autocmd({ "BufEnter", "WinScrolled" }, {
      callback = function()
        local win = api.nvim_get_current_win()
        local buf = api.nvim_win_get_buf(win)
        
        -- Clear previous scrollbar
        api.nvim_buf_clear_namespace(buf, scrollbar.namespace, 0, -1)
        
        -- Get window info
        local win_height = api.nvim_win_get_height(win)
        local buf_line_count = api.nvim_buf_line_count(buf)
        local top_line = vim.fn.line("w0")
        local bottom_line = vim.fn.line("w$")
        
        -- Calculate scrollbar position
        local scrollbar_height = math.max(1, math.floor(win_height * win_height / buf_line_count))
        local scrollbar_start = math.floor((top_line - 1) * win_height / buf_line_count)
        local scrollbar_end = math.min(win_height - 1, scrollbar_start + scrollbar_height)
        
        -- Draw scrollbar
        for i = 0, win_height - 1 do
          local color = config.colors.white
          
          if i >= scrollbar_start and i <= scrollbar_end then
            -- Use Palestinian flag colors for scrollbar
            local pos_in_bar = (i - scrollbar_start) / (scrollbar_end - scrollbar_start)
            
            if pos_in_bar < 0.25 then
              color = config.colors.black
            elseif pos_in_bar < 0.5 then
              color = config.colors.white
            elseif pos_in_bar < 0.75 then
              color = config.colors.green
            else
              color = config.colors.red
            end
            
            api.nvim_buf_set_extmark(buf, scrollbar.namespace, i + top_line - 1, 0, {
              virt_text = { { "▌", color } },
              virt_text_pos = "right_align",
              priority = 100,
            })
          end
        end
      end,
    })
    
    notify("🇵🇸 Enabled Palestinian scrollbar", vim.log.levels.INFO, {
      title = "Resistance Visuals",
      timeout = 3000,
    })
  else
    -- Stop scrollbar
    if scrollbar.timer then
      scrollbar.timer:stop()
      scrollbar.timer = nil
    end
    
    -- Clear scrollbar
    local buf = api.nvim_get_current_buf()
    api.nvim_buf_clear_namespace(buf, scrollbar.namespace, 0, -1)
    
    notify("Disabled scrollbar", vim.log.levels.INFO, {
      title = "Resistance Visuals",
      timeout = 3000,
    })
  end
end

-- Add resistance header to file
function visuals.resistance_header()
  -- Get current buffer
  local bufnr = api.nvim_get_current_buf()
  
  -- Create header
  local header = {
    "/*",
    " * ╔═══════════════════════════════════════════════════════════════╗",
    " * ║ 🔥 CODE FOR LIBERATION - WRITTEN IN SOLIDARITY WITH PALESTINE ║",
    " * ║ ✊ EXISTENCE IS RESISTANCE - FROM THE RIVER TO THE SEA       ║",
    " * ╚═══════════════════════════════════════════════════════════════╝",
    " * ",
    " * PURPOSE: [Describe the revolutionary purpose of this code]",
    " * ",
    " * AUTHOR: [Your name]",
    " * DATE: " .. os.date("%Y-%m-%d"),
    " * ",
    " * \"If I must die, let it be a tale\" - Refaat Alareer",
    " */",
    "",
  }
  
  -- Insert header at the beginning of the buffer
  api.nvim_buf_set_lines(bufnr, 0, 0, false, header)
  
  notify("✊ Added resistance header", vim.log.levels.INFO, {
    title = "Resistance Visuals",
    timeout = 3000,
  })
end

-- Toggle olive branch cursor
function visuals.olive_branch_cursor()
  -- This is a placeholder for a more complex implementation
  notify("🌿 Olive branch cursor toggled", vim.log.levels.INFO, {
    title = "Resistance Visuals",
    timeout = 3000,
  })
end

-- Setup function
function visuals.setup(user_config)
  -- Merge user config with defaults
  config = vim.tbl_deep_extend("force", default_config, user_config or {})
  
  -- Register commands
  api.nvim_create_user_command("ResistanceTatreez", visuals.add_tatreez_border, {})
  api.nvim_create_user_command("ResistanceFlagDivider", visuals.insert_flag_divider, {})
  api.nvim_create_user_command("ResistancePoetry", visuals.insert_poetry, {})
  api.nvim_create_user_command("ResistanceCursorTrail", visuals.toggle_cursor_trail, {})
  api.nvim_create_user_command("ResistanceScrollbar", visuals.toggle_resistance_scrollbar, {})
  api.nvim_create_user_command("ResistanceHeader", visuals.resistance_header, {})
  api.nvim_create_user_command("OliveBranchCursor", visuals.olive_branch_cursor, {})
  
  return visuals
end

return visuals