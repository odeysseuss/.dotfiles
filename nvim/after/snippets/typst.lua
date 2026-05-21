return {
    ---@diagnostic disable: undefined-global
    s("typst", {
        t({ '#import "/utils/template.typ": conf' }),
        t({ "" }),
        t({ "", "#show: conf.with(title: " }),
        i({ 1, "Typst" }),
        t({ ")" }),
    }),
}
