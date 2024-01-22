local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

local lspDir = os.getenv("USERPROFILE") .. "/.lsps"

require('lspconfig').lua_ls.setup {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                }
            })
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
end
}

require'lspconfig'.omnisharp.setup {
    cmd = { "dotnet", lspDir .. "/OmniSharp/OmniSharp.dll" },

    enable_editorconfig_support = true,

    enable_ms_build_load_projects_on_demand = false,

    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,

    enable_import_completion = false,

    sdk_include_prereleases = true,

    analyze_open_documents_only = false,

    on_attach = on_attach,
}

require'lspconfig'.powershell_es.setup{
    bundle_path = lspDir ..'/PowerShellEditorServices',
  }

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})
