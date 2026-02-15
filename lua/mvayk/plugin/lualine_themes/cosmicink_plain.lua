-- CosmicInk config for lualine
-- Author: Yeeloman
-- MIT license, see LICENSE for more details.

local M = {}

function M.load()
  -- Default Theme Colors
  --[[ local colors = {
    BG = '#16181b',
    FG = '#c5c4c4',
    YELLOW = '#e8b75f',
    CYAN = '#00bcd4',
    DARKBLUE = '#2b3e50',
    GREEN = '#00e676',
    ORANGE = '#ff7733',
    VIOLET = '#7a3ba8',
    MAGENTA = '#d360aa',
    BLUE = '#4f9cff',
    RED = '#ff3344',
  }

  -- Mode colour
  local function get_mode_color()
    local mode_color = {
      n = colors.DARKBLUE,
      i = colors.VIOLET,
      v = colors.RED,
      [''] = colors.BLUE,
      V = colors.RED,
      c = colors.MAGENTA,
      no = colors.RED,
      s = colors.ORANGE,
      S = colors.ORANGE,
      [''] = colors.ORANGE,
      ic = colors.YELLOW,
      R = colors.ORANGE,
      Rv = colors.ORANGE,
      cv = colors.RED,
      ce = colors.RED,
      r = colors.CYAN,
      rm = colors.CYAN,
      ['r?'] = colors.CYAN,
      ['!'] = colors.RED,
      t = colors.RED,
    }
    return mode_color[vim.fn.mode()] or colors.FG
  end

  -- Opposite colour
  local function get_opposite_color(mode_color)
    local opposite_colors = {
      [colors.RED]       = colors.CYAN,
      [colors.BLUE]      = colors.ORANGE,
      [colors.GREEN]     = colors.MAGENTA,
      [colors.MAGENTA]   = colors.DARKBLUE,
      [colors.ORANGE]    = colors.BLUE,
      [colors.CYAN]      = colors.YELLOW,
      [colors.VIOLET]    = colors.GREEN,
      [colors.YELLOW]    = colors.RED,
      [colors.DARKBLUE]  = colors.VIOLET,
    }
    return opposite_colors[mode_color] or colors.FG
  end

  -- Animated (random non-mode) colour
  local function get_animated_color(mode_color)
    local all_colors = {
      colors.RED, colors.BLUE, colors.GREEN, colors.MAGENTA,
      colors.ORANGE, colors.CYAN, colors.VIOLET, colors.YELLOW, colors.DARKBLUE,
    }
    local possible = {}
    for _, c in ipairs(all_colors) do
      if c ~= mode_color then table.insert(possible, c) end
    end
    if #possible > 0 then
      return possible[math.random(#possible)]
    end
    return colors.FG
  end

  -- Middle colour (interpolated)
  local function interpolate_color(c1, c2, step)
    local blend = function(a, b, s) return math.floor(a + (b - a) * s) end
    local r1, g1, b1 = tonumber(c1:sub(2, 3), 16), tonumber(c1:sub(4, 5), 16), tonumber(c1:sub(6, 7), 16)
    local r2, g2, b2 = tonumber(c2:sub(2, 3), 16), tonumber(c2:sub(4, 5), 16), tonumber(c2:sub(6, 7), 16)
    local r = blend(r1, r2, step)
    local g = blend(g1, g2, step)
    local b = blend(b1, b2, step)
    return string.format('#%02X%02X%02X', r, g, b)
  end

  local function get_middle_color(step)
    step = step or 0.5
    local c1 = get_mode_color()
    local c2 = get_opposite_color(c1)
    return interpolate_color(c1, c2, step)
  end
]]
  -- Conditions
  local function hide_in_width()
    return vim.fn.winwidth(0) > 80
  end

  -- Random icons
  math.randomseed(os.time())

  local icon_sets = {
    stars  = { '★', '☆', '✧', '✦', '✶', '✷', '✸', '✹' },
    runes  = { '✠', '⛧', '𖤐', 'ᛟ', 'ᚨ', 'ᚱ', 'ᚷ', 'ᚠ', 'ᛉ', 'ᛊ', 'ᛏ', '☠', '☾', '♰', '✟', '☽', '⚚', '🜏' },
    hearts = { '❤', '♥', '♡', '❦', '❧' },
    waves  = { '≈', '∿', '≋', '≀', '⌀', '≣', '⌇' },
    crosses = { '☨', '✟', '♰', '♱', '⛨', '' },
  }

  local icon_sets_list = {}
  for _, set in pairs(icon_sets) do table.insert(icon_sets_list, set) end

  local function shuffle_table(tbl)
    for i = #tbl, 2, -1 do
      local j = math.random(i)
      tbl[i], tbl[j] = tbl[j], tbl[i]
    end
  end
  shuffle_table(icon_sets_list)

  local function reverse_table(tbl)
    local rev = {}
    for i = #tbl, 1, -1 do table.insert(rev, tbl[i]) end
    return rev
  end
  local reversed_icon_sets = reverse_table(icon_sets_list)

  local function get_random_icon(icons)
    return icons[math.random(#icons)]
  end

  -- Separator helper
  local function create_separator(side, use_mode_color)
    return {
      function() return side == 'left' and '' or '' end,
      color = function()
        --local col = use_mode_color and get_mode_color() or get_opposite_color(get_mode_color())
        --return { fg = col }
      end,
      padding = { left = 0 },
    }
  end

  -- Mode-based component
  local function create_mode_based_component(content, icon, color_fg, color_bg)
    return {
      content,
      icon = icon,
      color = function()
        -- local mode_color = get_mode_color()
        -- local opposite = get_opposite_color(mode_color)
        return {
          -- fg = color_fg or colors.FG,
          -- bg = color_bg or opposite,
          gui = 'bold',
        }
      end,
    }
  end

  -- Mode indicator
  local function mode()
    local map = {
      n = 'N', i = 'I', v = 'V', [''] = 'V', V = 'V',
      c = 'C', no = 'N', s = 'S', S = 'S', ic = 'I',
      R = 'R', Rv = 'R', cv = 'C', ce = 'C',
      r = 'R', rm = 'M', ['r?'] = '?', ['!'] = '!', t = 'T',
    }
    return map[vim.fn.mode()] or '[UNKNOWN]'
  end

  -- Config
  local config = {
    options = {
      component_separators = '',
      section_separators = '',

      theme = "auto",
      --[[ theme = {
        normal = { c = { fg = colors.FG, bg = colors.BG } },
        inactive = { c = { fg = colors.FG, bg = colors.BG } },
      }, ]]
      disabled_filetypes = { 'neo-tree', 'undotree', 'sagaoutline', 'diff' },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { 'location', color = { --[[ fg = colors.FG, ]] gui = 'bold' } } },
      lualine_x = { { 'filename', color = { --[[ fg = colors.FG, ]] gui = 'bold,italic' } } },
      lualine_y = {},
      lualine_z = {},
    },
  }

  local function ins_left(component) table.insert(config.sections.lualine_c, component) end
  local function ins_right(component) table.insert(config.sections.lualine_x, component) end

  -- LEFT
  ins_left { mode, color = function() return { --[[fg = colors.BG, bg = get_mode_color(), ]] gui = 'bold' } end, padding = { left = 1, right = 1 } }
  ins_left(create_separator('left', true))
  ins_left {
    function() return vim.fn.fnamemodify(vim.fn.getcwd(), ':t') end,
    icon = ' ',
    color = function()
      return vim.env.VIRTUAL_ENV
        and { --[[ fg = get_mode_color(), ]] gui = 'bold,strikethrough' }
        or  { --[[ fg = get_mode_color(), ]] gui = 'bold' }
    end,
  }
  ins_left(create_separator('right'))
  ins_left(create_mode_based_component('filename', nil --[[ colors.BG) ]]))
  ins_left(create_separator('left'))

  ins_left {
    function() return '' end,
    color = function() return { --[[ fg = get_middle_color()  ]]} end,
    cond = hide_in_width,
  }

  ins_left {
    function()
      local gs = vim.b.gitsigns_status_dict
      if gs then
        return string.format('+%d ~%d -%d', gs.added or 0, gs.changed or 0, gs.removed or 0)
      end
      return ''
    end,
    color = { --[[ fg = colors.YELLOW, ]] gui = 'bold' },
    cond = hide_in_width,
  }

  for _, icons in pairs(icon_sets_list) do
    ins_left {
      function() return get_random_icon(icons) end,
      color = function() return { --[[ fg = get_animated_color(get_mode_color()) ]] } end,
      cond = hide_in_width,
    }
  end

  ins_left { 'searchcount', color = { --[[ fg = colors.GREEN, ]] gui = 'bold' } }

  -- RIGHT
  ins_right {
    function()
      local reg = vim.fn.reg_recording()
      return reg ~= '' and '[' .. reg .. ']' or ''
    end,
    color = { fg = '#ff3344', gui = 'bold' },
    cond = function() return vim.fn.reg_recording() ~= '' end,
  }

  ins_right { 'selectioncount', color = { --[[ fg = colors.GREEN, ]] gui = 'bold' } }

  for _, icons in ipairs(reversed_icon_sets) do
    ins_right {
      function() return get_random_icon(icons) end,
      color = function() return { --[[ fg = get_animated_color(get_mode_color()) ]] } end,
      cond = hide_in_width,
    }
  end

  ins_right {
    function()
      local msg = 'No Active Lsp'
      local buf_ft = vim.bo.filetype
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if next(clients) == nil then return msg end

      local short = {
        pyright = 'py', tsserver = 'ts', rust_analyzer = 'rs', lua_ls = 'lua',
        clangd = 'c++', bashls = 'sh', jsonls = 'json', html = 'html',
        cssls = 'css', tailwindcss = 'tw', dockerls = 'docker',
        sqlls = 'sql', yamlls = 'yml',
      }
      for _, client in ipairs(clients) do
        local ft = client.config and client.config.filetypes
        if ft and vim.fn.index(ft, buf_ft) ~= -1 then
          return short[client.name] or client.name:sub(1, 2)
        end
      end
      return msg
    end,
    icon = ' ',
    color = { --[[ fg = colors.YELLOW, ]] gui = 'bold' },
  }

  ins_right {
    function() return '' end,
    color = function() return { --[[ fg = get_middle_color() ]] } end,
    cond = hide_in_width,
  }

  ins_right(create_separator('right'))
  ins_right(create_mode_based_component('location', nil--[[ , colors.BG ]]))
  ins_right(create_separator('left'))

  ins_right {
    'branch',
    icon = ' ',
    fmt = function(branch)
      if not branch or branch == '' then return 'No Repo' end

      local segments = {}
      for seg in branch:gmatch('[^/]+') do table.insert(segments, seg) end

      if #segments == 0 then return 'No Repo' end
      if #segments == 1 then return segments[1] end

      for i = 1, #segments - 1 do
        segments[i] = segments[i]:sub(1, 1)
      end
      segments[1] = segments[1]:upper()
      for i = 2, #segments - 1 do
        segments[i] = segments[i]:lower()
      end

      local truncated = table.concat(segments, '', 1, #segments - 1) .. '›' .. segments[#segments]
      if #truncated > 15 then truncated = truncated:sub(1, 15) .. '…' end
      return truncated
    end,
    color = function() return { --[[ fg = get_mode_color(), ]] gui = 'bold' } end,
  }

  ins_right(create_separator('right'))
  ins_right(create_mode_based_component('progress', nil--[[ , colors.BG) ]]))

  require('lualine').setup(config)
end

return M
