-- ============================================================
-- Options
-- ============================================================

vim.o.number = true
vim.o.list = true
vim.o.splitbelow = true
vim.o.splitright = true

-- ============================================================
-- Helpers
-- ============================================================

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- Color scheme
-- ============================================================

vim.pack.add { gh 'projekt0n/github-nvim-theme' }

-- Neovim detects the terminal background via OSC 11, so this follows macOS appearance.
local function apply_color_scheme()
  vim.cmd.colorscheme(vim.o.background == "light" and "github_light_default" or "github_dark_default")
end

apply_color_scheme()

-- The terminal's OSC 11 reply can land late, and OptionSet is suppressed during startup.
vim.api.nvim_create_autocmd("VimEnter", { once = true, callback = apply_color_scheme })
vim.api.nvim_create_autocmd("OptionSet", { pattern = "background", callback = apply_color_scheme })
