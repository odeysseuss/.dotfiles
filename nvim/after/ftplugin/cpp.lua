vim.opt_local.makeprg = "xmake build -j$(nproc)"
vim.b.testprg = "xmake test"
vim.b.execprg = "xmake run"
