-- Spinners adapted from: https://github.com/sindresorhus/cli-spinners
-- and https://github.com/j-hui/fidget.nvim
--
-- Some designs' names are made more descriptive; differences noted in comments.
-- Other designs are omitted for brevity.
--
-- You may want to adjust spinner_rate according to the number of frames of your
-- chosen spinner.

-- MIT License
--
-- Copyright (c) Sindre Sorhus <sindresorhus@gmail.com> (https://sindresorhus.com)
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local M = {
    dots = {
        "⠋",
        "⠙",
        "⠹",
        "⠸",
        "⠼",
        "⠴",
        "⠦",
        "⠧",
        "⠇",
        "⠏",
    },
    dots_negative = { -- dots2
        "⣾",
        "⣽",
        "⣻",
        "⢿",
        "⡿",
        "⣟",
        "⣯",
        "⣷",
    },
    dots_snake = { -- dots3
        "⠋",
        "⠙",
        "⠚",
        "⠒",
        "⠂",
        "⠂",
        "⠒",
        "⠲",
        "⠴",
        "⠦",
        "⠖",
        "⠒",
        "⠐",
        "⠐",
        "⠒",
        "⠓",
        "⠋",
    },
    dots_footsteps = { -- dots10
        "⢄",
        "⢂",
        "⢁",
        "⡁",
        "⡈",
        "⡐",
        "⡠",
    },
    dots_hop = { -- dots11
        "⠁",
        "⠂",
        "⠄",
        "⡀",
        "⢀",
        "⠠",
        "⠐",
        "⠈",
    },
    line = {
        "-",
        "\\",
        "|",
        "/",
    },
    pipe = {
        "┤",
        "┘",
        "┴",
        "└",
        "├",
        "┌",
        "┬",
        "┐",
    },
    dots_ellipsis = { -- simpleDots
        ".  ",
        ".. ",
        "...",
        "   ",
    },
    dots_scrolling = { -- simpleDotsScrolling
        ".  ",
        ".. ",
        "...",
        " ..",
        "  .",
        "   ",
    },
    star = {
        "✶",
        "✸",
        "✹",
        "✺",
        "✹",
        "✷",
    },
    flip = {
        "_",
        "_",
        "_",
        "-",
        "`",
        "`",
        "'",
        "´",
        "-",
        "_",
        "_",
        "_",
    },
    hamburger = {
        "☱",
        "☲",
        "☴",
    },
    grow_vertical = { -- growVertical
        "▁",
        "▃",
        "▄",
        "▅",
        "▆",
        "▇",
        "▆",
        "▅",
        "▄",
        "▃",
    },
    grow_horizontal = { -- growHorizontal
        "▏",
        "▎",
        "▍",
        "▌",
        "▋",
        "▊",
        "▉",
        "▊",
        "▋",
        "▌",
        "▍",
        "▎",
    },
    noise = {
        "▓",
        "▒",
        "░",
    },
    dots_bounce = { -- bounce
        "⠁",
        "⠂",
        "⠄",
        "⠂",
    },
    triangle = {
        "◢",
        "◣",
        "◤",
        "◥",
    },
    arc = {
        "◜",
        "◠",
        "◝",
        "◞",
        "◡",
        "◟",
    },
    circle = {
        "◡",
        "⊙",
        "◠",
    },
    square_corners = { -- squareCorners
        "◰",
        "◳",
        "◲",
        "◱",
    },
    circle_quarters = { -- circleQuarters
        "◴",
        "◷",
        "◶",
        "◵",
    },
    circle_halves = { -- circleHalves
        "◐",
        "◓",
        "◑",
        "◒",
    },
    dots_toggle = { -- toggle
        "⊶",
        "⊷",
    },
    box_toggle = { -- toggle2
        "▫",
        "▪",
    },
    arrow = {
        "←",
        "↖",
        "↑",
        "↗",
        "→",
        "↘",
        "↓",
        "↙",
    },
    zip = { -- arrow3
        "▹▹▹▹▹",
        "▸▹▹▹▹",
        "▹▸▹▹▹",
        "▹▹▸▹▹",
        "▹▹▹▸▹",
        "▹▹▹▹▸",
    },
    bouncing_bar = { -- bouncingBar
        "[    ]",
        "[=   ]",
        "[==  ]",
        "[=== ]",
        "[ ===]",
        "[  ==]",
        "[   =]",
        "[    ]",
        "[   =]",
        "[  ==]",
        "[ ===]",
        "[====]",
        "[=== ]",
        "[==  ]",
        "[=   ]",
    },
    bouncing_ball = { -- bouncingBall
        "( ●    )",
        "(  ●   )",
        "(   ●  )",
        "(    ● )",
        "(     ●)",
        "(    ● )",
        "(   ●  )",
        "(  ●   )",
        "( ●    )",
        "(●     )",
    },
    clock = {
        "🕛 ",
        "🕐 ",
        "🕑 ",
        "🕒 ",
        "🕓 ",
        "🕔 ",
        "🕕 ",
        "🕖 ",
        "🕗 ",
        "🕘 ",
        "🕙 ",
        "🕚 ",
    },
    earth = {
        "🌍 ",
        "🌎 ",
        "🌏 ",
    },
    moon = {
        "🌑 ",
        "🌒 ",
        "🌓 ",
        "🌔 ",
        "🌕 ",
        "🌖 ",
        "🌗 ",
        "🌘 ",
    },
    dots_pulse = { -- point
        "∙∙∙",
        "●∙∙",
        "∙●∙",
        "∙∙●",
        "∙∙∙",
    },
    meter = { -- aesthetic
        "▰▱▱▱▱▱▱",
        "▰▰▱▱▱▱▱",
        "▰▰▰▱▱▱▱",
        "▰▰▰▰▱▱▱",
        "▰▰▰▰▰▱▱",
        "▰▰▰▰▰▰▱",
        "▰▰▰▰▰▰▰",
        "▰▱▱▱▱▱▱",
    },
}
return M
