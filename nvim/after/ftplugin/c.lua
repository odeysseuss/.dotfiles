vim.opt_local.makeprg =
"mkdir -p build && cmake -DCMAKE_BUILD_TYPE=Debug -B build -G Ninja && cmake --build build --parallel $(nproc)"
vim.b.testprg = "mkdir -p build && ctest --test-dir build --output-on-failure"
vim.b.execprg = "cmake run"
