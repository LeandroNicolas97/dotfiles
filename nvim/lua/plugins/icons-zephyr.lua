return {

--iCONOS ZEPHYR--
require('nvim-web-devicons').setup({
    override = {
        ["CMakeLists.txt"] = {
            icon = "CM",
            color = "#4756f0",
            cterm_color = "66",
            name = "CMakeLists"
        },
        ["prj.conf"] = {
            icon = "",
            color = "#a074c4",
            cterm_color = "140",
            name = "PrjConf"
        },
        ["dts"] = {
            icon = "dts",
            color = "#FFD700",
            cterm_color = "184",
            name = "DTS"
        },
        ["dtsi"] = {
            icon = "dtsi",
            color = "#cd2551",
            cterm_color = "184",
            name = "DTSI"
        },
        ["yaml"] = {
            icon = "",
            color = "#8af047",
            cterm_color = "66",
            name = "YAML"
        }
    },
    default = true,
})
}
