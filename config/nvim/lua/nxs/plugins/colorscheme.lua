return {
  "diegoulloao/neofusion.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("neofusion").setup({
      overrides = {
        -- FIXME: Manually add nvim cmp highlight equivalent since neofusion
        -- isn't updated with blink highlights yet.
        BlinkCmpLabel = { link = "NeofusionFg0" },
        BlinkCmpLabelDeprecated = { link = "NeofusionFg1" },
        BlinkCmpLabelMatch = { link = "NeofusionBlueBold" },
        BlinkCmpLabelDetail = { link = "NeofusionGray" },
        BlinkCmpLabelDescription = { link = "NeofusionGray" },
        BlinkCmpSource = { link = "NeofusionGray" },
        BlinkCmpKindText = { link = "NeofusionOrange" },
        BlinkCmpKindMethod = { link = "NeofusionBlue" },
        BlinkCmpKindFunction = { link = "NeofusionBlue" },
        BlinkCmpKindConstructor = { link = "NeofusionYellow" },
        BlinkCmpKindField = { link = "NeofusionBlue" },
        BlinkCmpKindVariable = { link = "NeofusionOrange" },
        BlinkCmpKindClass = { link = "NeofusionYellow" },
        BlinkCmpKindInterface = { link = "NeofusionYellow" },
        BlinkCmpKindModule = { link = "NeofusionBlue" },
        BlinkCmpKindProperty = { link = "NeofusionBlue" },
        BlinkCmpKindUnit = { link = "NeofusionBlue" },
        BlinkCmpKindValue = { link = "NeofusionOrange" },
        BlinkCmpKindEnum = { link = "NeofusionYellow" },
        BlinkCmpKindKeyword = { link = "NeofusionPurple" },
        BlinkCmpKindSnippet = { link = "NeofusionGreen" },
        BlinkCmpKindColor = { link = "NeofusionPurple" },
        BlinkCmpKindFile = { link = "NeofusionBlue" },
        BlinkCmpKindReference = { link = "NeofusionPurple" },
        BlinkCmpKindFolder = { link = "NeofusionBlue" },
        BlinkCmpKindEnumMember = { link = "NeofusionAqua" },
        BlinkCmpKindConstant = { link = "NeofusionOrange" },
        BlinkCmpKindStruct = { link = "NeofusionYellow" },
        BlinkCmpKindEvent = { link = "NeofusionPurple" },
        BlinkCmpKindOperator = { link = "NeofusionYellow" },
        BlinkCmpKindTypeParameter = { link = "NeofusionYellow" },
      },
    })

    vim.o.background = "dark"
    vim.cmd("colorscheme neofusion")
  end,
}
