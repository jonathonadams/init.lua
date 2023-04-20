return {
    { "folke/lazy.nvim", version = "*" },
    {
        "folke/drop.nvim",
        event = "VeryLazy",
        enabled = true,
        config = function()
            math.randomseed(os.time())
            local theme = ({ "stars", "snow", "xmas" })[math.random(1, 3)]
            require("drop").setup({ theme = theme })
        end,
    }
}
