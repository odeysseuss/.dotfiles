vim.opt_local.makeprg = "xmake f -m debug && xmake build -a -v"
vim.b.execprg = "xmake run"
vim.b.testprg = "xmake -r test"
