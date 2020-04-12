local m = {}
m.Reset = "\x1B[0m"
m.Rfg = "\x1B[39m"
m.Rbg = "\x1B[49m"

m.fg_black = "\x1B[30m"

m.bg_black = "\x1B[40m"

m.fg_red = "\x1B[31m"

m.bg_red = "\x1B[41m"

m.fg_green = "\x1B[32m"

m.bg_green = "\x1B[42m"

m.fg_yellow = "\x1B[33m"

m.bg_yellow = "\x1B[43m"

m.fg_blue = "\x1B[34m"

m.bg_blue = "\x1B[44m"

m.fg_magenta = "\x1B[35m"

m.bg_magenta = "\x1B[45m"

m.fg_cyan = "\x1B[36m"

m.bg_cyan = "\x1B[46m"

m.fg_white = "\x1B[37m"

m.bg_white = "\x1B[47m"

m.fg_bblack = "\x1B[90m"

m.bg_bblack = "\x1B[100m"

m.fg_bred = "\x1B[91m"

m.bg_bred = "\x1B[101m"

m.fg_bgreen = "\x1B[92m"

m.bg_bgreen = "\x1B[102m"

m.fg_byellow = "\x1B[93m"

m.bg_byellow = "\x1B[103m"

m.fg_bblue = "\x1B[94m"

m.bg_bblue = "\x1B[104m"

function m.red_fg(string) return m.fg_red..string..m.Rfg end
function m.red_bg(string) return m.bg_red..string..m.Rbg end

function m.black_fg(string) return m.fg_black..string..m.Rfg end
function m.black_bg(string) return m.bg_black..string..m.Rbg end

function m.green_fg(string) return m.fg_green..string..m.Rfg end
function m.green_bg(string) return m.bg_green..string..m.Rbg end

function m.yellow_fg(string) return m.fg_yellow..string..m.Rfg end
function m.yellow_bg(string) return m.bg_yellow..string..m.Rbg end

function m.blue_fg(string) return m.fg_blue..string..m.Rfg end
function m.blue_bg(string) return m.bg_blue..string..m.Rbg end

function m.magenta_fg(string) return m.fg_magenta..string..m.Rfg end
function m.magenta_bg(string) return m.bg_magenta..string..m.Rbg end

function m.cyan_fg(string) return m.fg_cyan..string..m.Rfg end
function m.cyan_bg(string) return m.bg_cyan..string..m.Rbg end

function m.white_fg(string) return m.fg_white..string..m.Rfg end
function m.white_bg(string) return m.bg_white..string..m.Rbg end

function m.bblack_fg(string) return m.fg_bblack..string..m.Rfg end
function m.bblack_bg(string) return m.bg_bblack..string..m.Rbg end

function m.bred_fg(string) return m.fg_bred..string..m.Rfg end
function m.bred_bg(string) return m.bg_bred..string..m.Rbg end

function m.bgreen_fg(string) return m.fg_bgreen..string..m.Rfg end
function m.bgreen_bg(string) return m.bg_bgreen..string..m.Rbg end

function m.byellow_fg(string) return m.fg_byellow..string..m.Rfg end
function m.byellow_bg(string) return m.bg_byellow..string..m.Rbg end

function m.bblue_fg(string) return m.fg_bblue..string..m.Rfg end
function m.bblue_bg(string) return m.bg_bblu..string..m.Rbg end
return m