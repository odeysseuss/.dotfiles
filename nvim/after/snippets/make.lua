local function makefile_snippet(lang, compiler, std)
    local ext = lang == "c" and "c" or "cpp"

    ---@diagnostic disable: undefined-global
    return {
        t({ "cc := " .. compiler }),
        t({ "", "cflags := -std=" .. std .. " -Wall -Wextra -pedantic -MMD -MP" }),
        t({ "", "incdir := -I" }),
        i(1, "include"),
        t({ "", "objdir := build/obj" }),
        t({ "", "" }),
        t({ "", "MODE ?= debug" }),
        t({ "", "ifeq ($(MODE), release)" }),
        t({ "", "\tcflags += -O2 -ffast-math -march=native" }),
        t({ "", "else" }),
        t({ "", "\tcflags += -g3 -fsanitize=address,undefined,leak" }),
        t({ "", "endif" }),
        t({ "", "" }),
        t({ "", "srcs := $(wildcard src/*." .. ext .. ")" }),
        t({ "", "objs := $(srcs:src/%." .. ext .. "=$(objdir)/%.o)" }),
        t({ "", "deps := $(srcs:src/%." .. ext .. "=$(objdir)/%.d)" }),
        t({ "", "exec := build/" }),
        i(1, "main"),
        t({ "", "-include $(deps)" }),
        t({ "", "" }),
        t({ "", "all: $(exec)" }),
        t({ "", "" }),
        t({ "", "run: $(exec)" }),
        t({ "", "\t./$(exec)" }),
        t({ "", "" }),
        t({ "", "$(exec): $(objs)" }),
        t({ "", "\t$(cc) $^ -o $@" }),
        t({ "", "" }),
        t({ "", "$(objdir)/%.o: src/%." .. ext .. " | $(objdir)" }),
        t({ "", "\t$(cc) $(cflags) $(incdir) -c $< -o $@" }),
        t({ "", "" }),
        t({ "", "$(objdir):" }),
        t({ "", "\tmkdir -p $@" }),
        t({ "", "" }),
        t({ "", "clean:" }),
        t({ "", "\trm -rf $(exec) $(objdir)" }),
        t({ "", "" }),
        t({ "", "# passing arguments" }),
        t({ "", "# %:" }),
        t({ "", "# \t@:" }),
    }
end

return {
    s("makefile_c", makefile_snippet("c", "clang", "c11")),
    s("makefile_cpp", makefile_snippet("c++", "clang++", "c++17")),
}
