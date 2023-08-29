local hydra_header = {
    [[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ]],
    [[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
    [[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ]],
    [[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
    [[          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
    [[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
    [[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
    [[ ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
    [[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ]],
    [[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
    [[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
}


local quotes = {
    {
        "If you don't fail at least 90% of the time, you're not aiming high enough.",
        "- Alan Kay",
    },
    {
        "Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away.",
    },
    {
        "If you don't make mistakes, you're not working on hard enough problems.",
        "- Frank Wilczek",
    },
    {
        "Crash early.",
        "A dead program normally does a lot less damage than a crippled one.",
    },
    { "They did not know it was impossible, so they did it!", "", "- Mark Twain" },
    {
        "If debugging is the process of removing bugs, then programming must be the process of putting them in.",
        "- Edsger W. Dijkstra",
    },
    {
        "The most important property of a program is whether it accomplishes the intention of its user.",
        "",
        "- C.A.R. Hoare",
    },
    {
        "The best thing about a boolean is even if you are wrong, you are only off by a bit.",
        "- Anonymous",
    },
    {
        "The best way to predict the future is to invent it.",
        "- Alan Kay",
    },
    {
        "The computing scientist’s main challenge is not to get confused by the complexities of his own making.",
        "- E. W. Dijkstra",
    },
    {
        "The goal of software engineering is to control complexity, not to create it.",
        "- Dr. Pamela Zave",
    },
    {
        "The only way to learn a new programming language is by writing programs in it.",
        "- Dennis Ritchie",
    },
    {
        "The trouble with programmers is that you can never tell what a programmer is doing until it’s too late.",
        "- Seymour Cray",
    },
    {"long time_ago; // in a galaxy far away"},
    {"Nothing is more permanent than a temporary fix."},
    {"If you were wondering why Monitors sleep and Keyboards don't,", "remember that Keyboards have two SHIFTS."},
    {"The only thing an average tells you is half of your customers are having a worse experience."},
    {"I will take what is mine with fire and blood."},
    {"Embrace the adventure!"},
};

function random_quote()
    math.randomseed(os.clock())
    local index = math.random() * #quotes
    return quotes[math.floor(index) + 1]
end


local settings = {
    -- every line should be same width without escaped \
    header = {
        type = "text",
        align = "center",
        fold_section = false,
        title = "Header",
        margin = 5,
        content = hydra_header,
        highlight = "Identifier",
        default_color = "#FF0000",
        oldfiles_amount = 0,
    },
    header_2 = {
        type = "text",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Quote",
        margin = 5,
        content = random_quote(),
        highlight = "Identifier",
        default_color = "",
        oldfiles_amount = 0,
    },
    body = {
        type = "text",
        align = "center",
        fold_section = false,
        title = "Useful commands",
        margin = 5,
        content = {
            "Fix code        \\f                     ",
            "Toggle comment  \\c                     ",
            "Toggle theme    \\t                     ",
            ":split                                 ",
            ":vsplit                                ",
            "<Ctrl>+o        Jump back              ",
            "F5              File browser           ",
            "F6              Symbol browser         ",
            "F11             Buffer browser         ",
            "",
            "<Ctrl>+n        Multicursor search next",
            "<Ctrl>+Down     Multicursor down       ",
        },
        highlight = "String",
        default_color = "",
        oldfiles_amount = 0,
    },
    body_2 = {
        type = "oldfiles",
        oldfiles_directory = true,
        align = "center",
        fold_section = false,
        title = "Oldfiles of Directory",
        margin = 5,
        content = {},
        highlight = "TSString",
        default_color = "#FFFFFF",
        oldfiles_amount = 5,
    },
    footer = {
        type = "oldfiles",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Oldfiles",
        margin = 5,
        content = { "startup.nvim" },
        highlight = "TSString",
        default_color = "#FFFFFF",
        oldfiles_amount = 5,
    },


    options = {
        after = function()
            require("startup.utils").oldfiles_mappings()
        end,
        mapping_keys = true,
        cursor_column = 0.5,
        empty_lines_between_mappings = true,
        disable_statuslines = true,
        paddings = { 2, 2, 2, 2, 2, 2, 2 },
    },
    mappings = {
        open_file = "<CR>",
    },
    parts = {
        "header",
        "header_2",
        "body",
        "body_2",
        "footer",
    },
}
return settings
