 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#f7e7fe',
    base01 = '#e8bcfb',
    base02 = '#e1a9fa',
    base03 = '#c05beb',
    base04 = '#50066f',
    base05 = '#6f099a',
    base06 = '#6f099a',
    base07 = '#6f099a',
    base08 = '#f33971',
    base09 = '#bcfbe8',
    base0A = '#ebc5fc',
    base0B = '#8e0cc6',
    base0C = '#099067',
    base0D = '#670990',
    base0E = '#670891',
    base0F = '#890ac2',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#6f099a',          bg = '#f7e7fe' })
  hi('TelescopeBorder',         { fg = '#c05beb',             bg = '#f7e7fe' })
  hi('TelescopePromptNormal',   { fg = '#6f099a',          bg = '#f7e7fe' })
  hi('TelescopePromptBorder',   { fg = '#c05beb',             bg = '#f7e7fe' })
  hi('TelescopePromptPrefix',   { fg = '#8e0cc6',             bg = '#f7e7fe' })
  hi('TelescopePromptCounter',  { fg = '#50066f',  bg = '#f7e7fe' })
  hi('TelescopePromptTitle',    { fg = '#f7e7fe',             bg = '#8e0cc6' })
  hi('TelescopePreviewTitle',   { fg = '#f7e7fe',             bg = '#ebc5fc' })
  hi('TelescopeResultsTitle',   { fg = '#f7e7fe',             bg = '#bcfbe8' })
  hi('TelescopeSelection',      { fg = '#6f099a',          bg = '#e1a9fa' })
  hi('TelescopeSelectionCaret', { fg = '#8e0cc6',             bg = '#e1a9fa' })
  hi('TelescopeMatching',       { fg = '#8e0cc6',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#6f099a',          bg = '#f7e7fe' })
  hi('MiniPickBorder',         { fg = '#c05beb',             bg = '#f7e7fe' })
  hi('MiniPickPrompt',   { fg = '#6f099a',          bg = '#f7e7fe' })
  hi('MiniPickPromptPrefix',   { fg = '#8e0cc6',             bg = '#f7e7fe' })
  hi('MiniPickBorderText',    { fg = '#f7e7fe',             bg = '#8e0cc6' })
  hi('MiniPickMatchCurrent',      { fg = '#6f099a',          bg = '#e1a9fa' })
  hi('MiniPickPromptCaret', { fg = '#8e0cc6',             bg = '#e1a9fa' })
  hi('MiniPickMatchRanges',       { fg = '#8e0cc6',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
