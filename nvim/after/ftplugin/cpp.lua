vim.opt_local.makeprg =
    "mkdir -p build && cmake -DCMAKE_BUILD_TYPE=Debug -B build -G Ninja && cmake --build build --parallel $(nproc)"
