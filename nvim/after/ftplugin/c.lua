vim.b.makeprg = "xmake f -m debug && xmake build -a -v"
vim.b.execprg = "xmake run" -- custom
vim.b.testprg = "xmake -r test" -- custom
