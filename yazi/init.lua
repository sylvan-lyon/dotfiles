-- ~/.config/yazi/init.lua
th.git = th.git or {}
th.git.modified_sign = "m"
th.git.added_sign = "+"
th.git.untracked_sign = "u"
th.git.ignored_sign = "/"
th.git.deleted_sign = "-"
th.git.updated_sign = "✓"

th.git.modified = ui.Style():fg("yellow")
th.git.added = ui.Style():fg("green")
th.git.untracked = ui.Style():fg("green"):dim()
th.git.ignored = ui.Style():fg("white"):dim()
th.git.deleted = ui.Style():fg("red"):bold()
th.git.updated = ui.Style():fg("green"):bold()

require("git"):setup()
require("full-border"):setup()
require("starship"):setup()
