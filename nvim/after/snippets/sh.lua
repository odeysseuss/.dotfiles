return {
    ---@diagnostic disable: undefined-global
    s("state", {
        t({ "#!/usr/bin/env bash" }),
        t({ "", "" }),
        t({ "", "set -euo pipefail" }),
        t({ "", "" }),
    }),
    s("colors", {
        t({ "", "RED='\\033[1;31m'" }),
        t({ "", "GREEN='\\033[1;32m'" }),
        t({ "", "YELLOW='\\033[1;33m'" }),
        t({ "", "BLUE='\\033[1;34m'" }),
        t({ "", "CYAN='\\033[1;36m'" }),
        t({ "", "NC='\\033[0m'" }),
    }),
}
