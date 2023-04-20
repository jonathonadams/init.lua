return {
    {
        "zbirenbaum/copilot.lua",
        event = { "InsertEnter" },
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false
                },
                suggestion = {
                    enabled = false,
                  --  auto_trigger = false,
                },
            })
        end,
    },
    {
      "zbirenbaum/copilot-cmp",
      dependencies = { "copilot.lua" },
      config = function ()
      require("copilot_cmp").setup()
      end
    }
}
