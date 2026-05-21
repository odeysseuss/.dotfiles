return {
    ---@diagnostic disable: undefined-global
    s("bash", {
        t({ "#!/usr/bin/env bash" }),
        t({ "", "" }),
        t({ "", "set -euo pipefail" }),
        t({ "", "" }),
    }),
}
