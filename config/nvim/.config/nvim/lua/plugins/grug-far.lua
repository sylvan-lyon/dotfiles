return {
    "MagicDuck/grug-far.nvim",
    name = "grug-far",
    cmd = {
        "GrugFar",
        "GrugFarWithin",
    },
    config = function()
        require("grug-far").setup({});
    end
}
