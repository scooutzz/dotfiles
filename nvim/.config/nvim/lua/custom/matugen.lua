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
	primary = "#88d0ec",
	on_primary = "#003544",

	-- Cores de superfície
	surface = "#0f1416",
	surface_bright = "#353a3d",
	surface_dim = "#0f1416",
	surface_container = "#1b2023",
	surface_container_high = "#252b2d",
	surface_container_highest = "#303638",
	surface_container_low = "#171c1f",
	surface_container_lowest = "#0a0f11",

	on_surface = "#dee3e6",
	on_surface_variant = "#bfc8cc",

	-- Cores de destaque
	secondary = "#b3cad5",
	on_secondary = "#1e333c",
	tertiary = "#c3c3eb",
	on_tertiary = "#2c2d4d",

	-- Cores de erro/aviso
	error = "#ffb4ab",
	on_error = "#690005",

	-- Cores de contorno
	outline = "#8a9296",
	outline_variant = "#40484c",

	-- Background
	background = "#0f1416",
	on_background = "#dee3e6",
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
-- 	base00 = "#0f1416", -- background
-- 	base01 = "#dee3e6", -- surface
-- 	base02 = "#bfc8cc", -- surface_variant
-- 	base03 = "#bfc8cc", -- comments/dim / outline / muted
-- 	base04 = "#bfc8cc", -- on_surface_variant
-- 	base05 = "#dee3e6", -- foreground / on_surface
-- 	base06 = "#2c3134", -- inverse_on_surface
-- 	base07 = "#88d0ec", -- primary
-- 	base08 = "#ffb4ab", -- red (error)
-- 	base09 = "#c3c3eb", -- orange (tertiary / or primary_container)
-- 	base0A = "#b3cad5", -- yellow (secondary)
-- 	base0B = "#09677f", -- green (primairy_container / or secondary_container)
-- 	base0C = "#354a53", -- cyan (secondary_container / or parimary)
-- 	base0D = "#88d0ec", -- blue (tertiary_container / or primary)
-- 	base0E = "#88d0ec", -- magenta (on_primary_container / or tertiary)
-- 	base0F = "#ffb4ab", -- brown (error_container / or outline_variant)
-- }
