return { 
    'rmagatti/auto-session',
    dependencies = {},
    config = function()
        require("auto-session").setup {
            log_level = "error"
        }
    end,
}
