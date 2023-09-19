--: help options
local options = {
	backup 				= false,
	clipboard 		= "unnamedplus",
	tabstop 			= 2,
	shiftwidth 		= 2,
	foldcolumn 		= "1",
	conceallevel 	= 0,              -- so that `` is visible in markdown files
	encoding 			= "utf-8",
	--guicursor 		= true,			 		-- cursor is block, even in ins mode
	hidden 				= true,							-- can navigate away from unsaved file
	wrap 					= false,
	hlsearch 			= false,
	incsearch 		= true, 	        --cursor will jump to match while typing
	scrolloff 		= 4,
	cursorline 		= true,           -- highlight the current line
	termguicolors = true,         --
	splitbelow 		= true, 							-- windows split in a more harmonious way
	splitright 		= true,

}

-- 2 ways to access table element, for reference
-- vim.opt.columns = 90 
-- options['columns'] = 90

for k, v in pairs(options) do			
	vim.opt[k] = v
end
