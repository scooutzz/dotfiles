return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			current_line_blame = true,

			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				-- Hunk Navigation
				map("n", "]c", gs.next_hunk, "Gitsigns: Next Hunk")
				map("n", "[c", gs.prev_hunk, "Gitsigns: Previous Hunk")

				-- Preview Hunk
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Gitsigns: Preview Hunk")

				-- Reset Hunk
				map({ "n", "x" }, "<leader>ghr", gs.reset_hunk, "Gitsigns: Reset Hunk")
			end,
		})
	end,
}
