if vim.fn.filereadable("CMakeLists.txt") == 1 then
    vim.opt_local.makeprg =
    "mkdir -p build && cmake -DCMAKE_BUILD_TYPE=Debug -B build -G Ninja && cmake --build build --parallel $(nproc)"
    vim.b.testprg = "mkdir -p build && ctest --test-dir build --output-on-failure"
    vim.b.execprg = "cmake run"
else
    vim.opt_local.makeprg = "xmake f -m debug && xmake build -a -v"
    vim.b.testprg = "xmake -r test"
    vim.b.execprg = "xmake run"
end
