-- ┳┓┏┓┏┓┓┏┳┳┳┓
-- ┃┃┣ ┃┃┃┃┃┃┃┃
-- ┛┗┗┛┗┛┗┛┻┛ ┗
--

-- Colorscheme gerado automaticamente pelo matugen
-- Não edite este arquivo manualmente

local M = {}

-- Cores base do matugen
local colors = {
	-- Cores primárias
	primary = "{{colors.primary.default.hex}}",
	on_primary = "{{colors.on_primary.default.hex}}",

	-- Cores de superfície
	surface = "{{colors.surface.default.hex}}",
	surface_bright = "{{colors.surface_bright.default.hex}}",
	surface_dim = "{{colors.surface_dim.default.hex}}",
	surface_container = "{{colors.surface_container.default.hex}}",
	surface_container_high = "{{colors.surface_container_high.default.hex}}",
	surface_container_highest = "{{colors.surface_container_highest.default.hex}}",
	surface_container_low = "{{colors.surface_container_low.default.hex}}",
	surface_container_lowest = "{{colors.surface_container_lowest.default.hex}}",

	on_surface = "{{colors.on_surface.default.hex}}",
	on_surface_variant = "{{colors.on_surface_variant.default.hex}}",

	-- Cores de destaque
	secondary = "{{colors.secondary.default.hex}}",
	on_secondary = "{{colors.on_secondary.default.hex}}",
	tertiary = "{{colors.tertiary.default.hex}}",
	on_tertiary = "{{colors.on_tertiary.default.hex}}",

	-- Cores de erro/aviso
	error = "{{colors.error.default.hex}}",
	on_error = "{{colors.on_error.default.hex}}",

	-- Cores de contorno
	outline = "{{colors.outline.default.hex}}",
	outline_variant = "{{colors.outline_variant.default.hex}}",

	-- Background
	background = "{{colors.background.default.hex}}",
	on_background = "{{colors.on_background.default.hex}}",
}

-- Função para aplicar o colorscheme
function M.setup()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.background = "dark" -- ou "light" baseado nas cores
	vim.g.colors_name = "matugen"

	-- Grupos de highlight básicos
	local highlights = {
		-- Interface básica
		Normal = { fg = colors.on_background, bg = colors.background },
		NormalFloat = { fg = colors.on_surface, bg = colors.surface_container },
		FloatBorder = { fg = colors.outline, bg = colors.surface_container },

		-- Cursor e seleção
		Cursor = { fg = colors.on_primary, bg = colors.primary },
		CursorLine = { bg = colors.surface_container_low },
		CursorColumn = { bg = colors.surface_container_low },
		Visual = { bg = colors.surface_container_high },

		-- Line numbers
		LineNr = { fg = colors.outline },
		CursorLineNr = { fg = colors.on_surface, bold = true },

		-- Status line
		StatusLine = { fg = colors.on_surface, bg = colors.surface_container },
		StatusLineNC = { fg = colors.on_surface_variant, bg = colors.surface_container_low },

		-- Tabs
		TabLine = { fg = colors.on_surface_variant, bg = colors.surface_container_low },
		TabLineFill = { bg = colors.surface },
		TabLineSel = { fg = colors.on_surface, bg = colors.surface_container_high },

		-- Popup menus
		Pmenu = { fg = colors.on_surface, bg = colors.surface_container },
		PmenuSel = { fg = colors.on_primary, bg = colors.primary },
		PmenuSbar = { bg = colors.surface_container_high },
		PmenuThumb = { bg = colors.outline },

		-- Search
		Search = { fg = colors.on_secondary, bg = colors.secondary },
		IncSearch = { fg = colors.on_tertiary, bg = colors.tertiary },

		-- Syntax highlighting
		Comment = { fg = colors.on_surface_variant, italic = true },
		String = { fg = colors.secondary },
		Number = { fg = colors.tertiary },
		Boolean = { fg = colors.tertiary },
		Function = { fg = colors.primary },
		Keyword = { fg = colors.primary, bold = true },
		Type = { fg = colors.secondary },
		Identifier = { fg = colors.on_surface },
		Constant = { fg = colors.tertiary },

		-- Diff
		DiffAdd = { bg = colors.surface_container_high },
		DiffChange = { bg = colors.surface_container },
		DiffDelete = { fg = colors.error, bg = colors.surface_container_low },
		DiffText = { bg = colors.surface_container_highest },

		-- Diagnostics
		ErrorMsg = { fg = colors.error },
		WarningMsg = { fg = colors.tertiary },

		-- Splits
		VertSplit = { fg = colors.outline },
		WinSeparator = { fg = colors.outline },

		-- Fold
		Folded = { fg = colors.on_surface_variant, bg = colors.surface_container_low },
		FoldColumn = { fg = colors.outline },
	}

	-- Aplicar highlights
	for group, opts in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- Highlights específicos para plugins populares
	-- Telescope
	vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.outline })
	vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.surface_container_high })

	-- Nvim-tree
	vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = colors.on_surface, bg = colors.surface_container_low })
	vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = colors.primary })

	-- LSP
	vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.error })
	vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.tertiary })
	vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.primary })
	vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.secondary })
end

return M

-- return {
-- 	base00 = "{{colors.surface.default.hex}}", -- background
-- 	base01 = "{{colors.on_surface.default.hex}}", -- surface
-- 	base02 = "{{colors.on_surface_variant.default.hex}}", -- surface_variant
-- 	base03 = "{{colors.on_surface_variant.default.hex}}", -- comments/dim / outline / muted
-- 	base04 = "{{colors.on_surface_variant.default.hex}}", -- on_surface_variant
-- 	base05 = "{{colors.on_surface.default.hex}}", -- foreground / on_surface
-- 	base06 = "{{colors.inverse_on_surface.default.hex}}", -- inverse_on_surface
-- 	base07 = "{{colors.primary.default.hex}}", -- primary
-- 	base08 = "{{colors.error.default.hex}}", -- red (error)
-- 	base09 = "{{colors.tertiary.default.hex}}", -- orange (tertiary / or primary_container)
-- 	base0A = "{{colors.secondary.default.hex}}", -- yellow (secondary)
-- 	base0B = "{{colors.inverse_primary.default.hex}}", -- green (primairy_container / or secondary_container)
-- 	base0C = "{{colors.secondary_container.default.hex}}", -- cyan (secondary_container / or parimary)
-- 	base0D = "{{colors.primary.default.hex}}", -- blue (tertiary_container / or primary)
-- 	base0E = "{{colors.primary.default.hex}}", -- magenta (on_primary_container / or tertiary)
-- 	base0F = "{{colors.error.default.hex}}", -- brown (error_container / or outline_variant)
-- }
