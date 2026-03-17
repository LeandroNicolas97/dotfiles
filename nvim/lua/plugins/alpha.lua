--- @type LazyPluginSpec
return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        require("alpha.term")
        local arttoggle = false

        -- Tamaño del logo
        local logo_width = 60  -- Ajusta el ancho del logo
        local logo_height = 10   -- Ajusta el alto del logo

        -- Logo de Neovim en ASCII art
        local logo = {
            [[                                                    ]],
            [[         ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
            [[         ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
            [[         ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
            [[         ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
            [[         ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
            [[         ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        }
        -- Configuración para arte alternativo
        local art = {
            -- { name, width, height }
            { "tohru", 20, 15 },
        }

        if arttoggle == true then
            dashboard.opts.opts.noautocmd = true
            dashboard.section.terminal.opts.redraw = true
            local path = vim.fn.stdpath("config") .. "/assets/"
            local currentart = art[1]
            dashboard.section.terminal.command = "cat " .. path .. currentart[1]
            dashboard.section.terminal.width = logo_width
            dashboard.section.terminal.height = logo_height

            dashboard.opts.layout = {
                dashboard.section.terminal,
                { type = "padding", val = 2 },
                dashboard.section.buttons,
                dashboard.section.footer,
            }
        else
            dashboard.section.header.val = logo
        end

        -- Configuración de los botones del dashboard
        dashboard.section.buttons.val = {
            dashboard.button(". ", "       " .. "   Neovim Config", ":Neotree /home/leandro/.config/nvim/lua <CR>"),

        }

        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end

        dashboard.section.header.opts.hl = "Function"
        dashboard.section.buttons.opts.hl = "Identifier"
        dashboard.section.footer.opts.hl = "Function"
        dashboard.opts.layout[1].val = logo_height
        return dashboard
    end,
    config = function(_, dashboard)
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        require("alpha").setup(dashboard.opts)
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local v = vim.version()
                local dev = ""
                if v.prerelease == "dev" then
                    dev = "-dev+" .. tostring(v.build)
                else
                    dev = ""
                end
                local version = v.major .. "." .. v.minor .. "." .. v.patch .. dev
                local stats = require("lazy").stats()
                local plugins_count = stats.loaded .. "/" .. stats.count
                local ms = math.floor(stats.startuptime + 0.5)
                local time = vim.fn.strftime("%H:%M:%S")
                local date = vim.fn.strftime("%d.%m.%Y")

                local line1 = "󰐫 " .. plugins_count .. " plugins loaded in " .. ms .. "ms"
                local line2 = "󰃭 " .. date .. "  󱑎 " .. time
                local line3 = " " .. version

                local line1_width = vim.fn.strdisplaywidth(line1)
                local line2Padded = string.rep(" ", (line1_width - vim.fn.strdisplaywidth(line2)) / 2) .. line2
                local line3Padded = string.rep(" ", (line1_width - vim.fn.strdisplaywidth(line3)) / 2) .. line3

                dashboard.section.footer.val = {
                    line1,
                    line2Padded,
                    line3Padded,
                }
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
