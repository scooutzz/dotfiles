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
	primary = "#85d2e8",
	on_primary = "#003641",

	-- Cores de superfície
	surface = "#0f1416",
	surface_bright = "#343a3c",
	surface_dim = "#0f1416",
	surface_container = "#1b2022",
	surface_container_high = "#252b2d",
	surface_container_highest = "#303638",
	surface_container_low = "#171c1e",
	surface_container_lowest = "#090f11",

	on_surface = "#dee3e6",
	on_surface_variant = "#bfc8cb",

	-- Cores de destaque
	secondary = "#b2cbd3",
	on_secondary = "#1d343a",
	tertiary = "#bfc4eb",
	on_tertiary = "#292e4d",

	-- Cores de erro/aviso
	error = "#ffb4ab",
	on_error = "#690005",

	-- Cores de contorno
	outline = "#899295",
	outline_variant = "#3f484b",

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
-- 	base02 = "#bfc8cb", -- surface_variant
-- 	base03 = "#bfc8cb", -- comments/dim / outline / muted
-- 	base04 = "#bfc8cb", -- on_surface_variant
-- 	base05 = "#dee3e6", -- foreground / on_surface
-- 	base06 = "#2c3133", -- inverse_on_surface
-- 	base07 = "#85d2e8", -- primary
-- 	base08 = "#ffb4ab", -- red (error)
-- 	base09 = "#bfc4eb", -- orange (tertiary / or primary_container)
-- 	base0A = "#b2cbd3", -- yellow (secondary)
-- 	base0B = "#00687b", -- green (primairy_container / or secondary_container)
-- 	base0C = "#344a51", -- cyan (secondary_container / or parimary)
-- 	base0D = "#85d2e8", -- blue (tertiary_container / or primary)
-- 	base0E = "#85d2e8", -- magenta (on_primary_container / or tertiary)
-- 	base0F = "#ffb4ab", -- brown (error_container / or outline_variant)
-- }
