local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require'lspconfig'.omnisharp.setup {
    cmd = { "dotnet", "C:/Users/jhenry/AppData/Local/Programs/OmniSharp/OmniSharp.dll" },

    enable_editorconfig_support = true,

    enable_ms_build_load_projects_on_demand = false,

    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,

    enable_import_completion = false,

    sdk_include_prereleases = true,

    analyze_open_documents_only = false,
}
