-- ====================================================================
-- Options
-- ====================================================================

vim.o.number = true
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true

-- ====================================================================
-- Helpers
-- ====================================================================

--- Because most plugins are hosted on GitHub, we can use the helper
--- function to have less repetition in the following sections.
--- @param repo string
--- @return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ====================================================================
-- Theme
-- ====================================================================

vim.pack.add { gh 'projekt0n/github-nvim-theme', gh 'nvim-tree/nvim-web-devicons' }

-- Neovim detects the terminal background via OSC 11, so this follows
-- macOS appearance.
local function apply_theme()
  local theme = vim.o.background == 'light' and 'github_light_default' or 'github_dark_default'
  if vim.g.colors_name ~= theme then vim.cmd.colorscheme(theme) end
end

-- The terminal's OSC 11 reply can land late, and OptionSet is
-- suppressed during startup. Defer until the background change finishes;
-- otherwise, it immediately clears the newly applied color scheme.
local function schedule_theme() vim.schedule(apply_theme) end

apply_theme()

vim.api.nvim_create_autocmd('VimEnter', { once = true, callback = schedule_theme })
vim.api.nvim_create_autocmd('OptionSet', { pattern = 'background', callback = schedule_theme })

-- ============================================================
-- Status line
-- ============================================================

vim.pack.add { gh 'nvim-lualine/lualine.nvim' }

vim.o.cmdheight = 0
vim.o.laststatus = 3
vim.o.showmode = false

require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_x = {'encoding', 'filetype'},
  },
}

-- ====================================================================
-- tree-sitter
-- ====================================================================

vim.pack.add { gh 'nvim-treesitter/nvim-treesitter' }

local ts = require('nvim-treesitter')

ts.install({
  'javascript',
  'jsx',
  'typescript',
  'tsx',
  'json',
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)

    if lang and vim.list_contains(ts.get_installed(), lang) then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})

-- ====================================================================
-- Blink
-- ====================================================================

vim.pack.add { gh 'Saghen/blink.lib', gh 'Saghen/blink.cmp' }

local cmp = require('blink.cmp')

cmp.build():pwait()
cmp.setup()

-- ====================================================================
-- LSP
-- ====================================================================

vim.pack.add { gh 'neovim/nvim-lspconfig', gh 'mason-org/mason.nvim', gh 'mason-org/mason-lspconfig.nvim' }

require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = {
    'ts_ls',
  },
}

-- ============================================================
-- Git
-- ============================================================

vim.pack.add { gh 'lewis6991/gitsigns.nvim' }

require('gitsigns').setup()
