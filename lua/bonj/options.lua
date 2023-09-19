--: help options
local options = {
	backup        = false,
	swapfile      = false,
	undodir 			= os.getenv("HOME") .. "/.vi/undodir",
	undofile 			= true,
	clipboard     = "unnamedplus",

	tabstop       = 4,
	softtabstop   = 4,
	shiftwidth    = 4,
	expandtab			=true,
	smartindent		=true,

	foldcolumn    = "1",
	conceallevel  = 0, -- so that `` is visible in markdown files
	encoding      = "utf-8",
	--guicursor 		= true,			 		-- cursor is block, even in ins mode
	hidden        = true, -- can navigate away from unsaved file
	wrap          = false,

	hlsearch      = false,
	incsearch     = true, --cursor will jump to match while typing

	scrolloff     = 8,
	signcolumn		="yes",
	cursorline    = true, -- highlight the current line
	updatetime		= 50,
	--colorcolumn		= "80", -- puts vertical line at column

	termguicolors = true, --
	splitbelow    = true, -- windows split in a more harmonious way
	splitright    = true,

}

-- 2 ways to access table element, for reference
-- vim.opt.columns = 90
-- options['columns'] = 90

for k, v in pairs(options) do
	vim.opt[k] = v
end
