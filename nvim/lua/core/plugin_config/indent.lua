require("ibl").setup {
    indent = {
        char = "│",
        smart_indent_cap = true,
        priority = 2,
        repeat_linebreak = false,
    },
    exclude = {
        filetypes = {"dashboard", "help", "terminal"},
        buftypes = {"terminal"}
    },
    viewport_buffer = {
        min = 30,
    },
    whitespace = {
        remove_blankline_trail = true,
    },
    scope = {
        enabled = false,  -- Disable the scope feature
    },
}

