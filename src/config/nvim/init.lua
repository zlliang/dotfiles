-- Options
vim.o.number = true
vim.o.list = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
vim.o.splitbelow = true
vim.o.splitright = true

-- Plugins
vim.pack.add({
  "https://github.com/projekt0n/github-nvim-theme",
}, { confirm = false })

-- Neovim detects the terminal background via OSC 11, so this follows macOS appearance.
local function apply_colorscheme()
  vim.cmd.colorscheme(vim.o.background == "light" and "github_light_default" or "github_dark_default")
end

apply_colorscheme()

-- The terminal's OSC 11 reply can land late, and OptionSet is suppressed during startup.
vim.api.nvim_create_autocmd("VimEnter", { once = true, callback = apply_colorscheme })
vim.api.nvim_create_autocmd("OptionSet", { pattern = "background", callback = apply_colorscheme })
