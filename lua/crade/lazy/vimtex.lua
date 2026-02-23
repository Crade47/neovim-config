
--[[
-- --------Using a different Engine--------
--to use xelatex write this on top of the .tex file:
--% !TeX program = xelatex
-- -------Getting a new font--------
-- first install the font using tlmgr
-- if the command ```fc-match "Libertinus Serif"``` does not return anything or mismatching info
-- then for eg copy and paste to the font library
-- cp /usr/local/texlive/2024/texmf-dist/fonts/opentype/public/libertinus/*.otf ~/Library/Fonts/
-- refresh cache: ```fc-cache -fv```
]]
return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = "skim"
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_quickfix_ignore_filters = { "Underfull", "Overfull",
            "LaTeX Warning: .\\+ float specifier changed to",
            "Package hyperref Warning: Token not allowed in a PDF string" }
    end
}
