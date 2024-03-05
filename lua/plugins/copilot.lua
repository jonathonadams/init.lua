return {
  {
    "zbirenbaum/copilot.lua",
    event = { "InsertEnter" },
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
        },
      })
    end,
  }
}
