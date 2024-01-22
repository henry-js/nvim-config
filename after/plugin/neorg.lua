require("neorg").setup {
    load = {
        ["core.defaults"] = {}, -- Loads dfefault behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    work = "~/notes/work",
                    home = "~/notes/home",
                },
            },
        },
    },
}
