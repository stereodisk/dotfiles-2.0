c = c
config = config

# ------------------------------------
# @YML Autoconfig
config.load_autoconfig(False)

# @BROWSER STYLE
config.source("themes/qute-city-lights/city-lights-theme.py")  # colorscheme

# Statusbar
c.statusbar.widgets = ["search_match", "text:in", "url", "scroll"]
c.statusbar.padding = {"top": 5, "bottom": 5, "left": 9, "right": 9}

# Tabs
c.tabs.show = "multiple"
c.tabs.indicator.width = 0
c.tabs.title.format = "{audio}{current_title}"  # Tabs style
c.tabs.padding = {"top": 5, "bottom": 5, "left": 9, "right": 9}

# Darkmode
c.colors.webpage.darkmode.enabled = False  # not forcing darkmode
c.colors.webpage.preferred_color_scheme = "dark"  # darkmode if possible
c.colors.webpage.darkmode.policy.images = "never"

# @KEYBINDS/ALIASES
# Aliases (commands)
c.aliases = {
    "q": "close",
    "qa": "quit",
    "w": "session-save",
    "wq": "quit --save",
    "wqa": "quit --save",
}

# Keymaps (keys)
c.bindings.key_mappings = {
    "<Ctrl+6>": "<Ctrl+^>",
    "<Ctrl+Enter>": "<Ctrl+Return>",
    "<Ctrl+i>": "<Tab>",
    "<Ctrl+j>": "<Return>",
    "<Ctrl+m>": "<Return>",
    "<Ctrl+[>": "<Escape>",
    "<Enter>": "<Return>",
    "<Shift+Enter>": "<Return>",
    "<Shift+Return>": "<Return>",
}
c.bindings.commands["normal"] = {
    ",": "cmd-set-text :open ~/",
}

# @QUIT
c.confirm_quit = [
    "multiple-tabs",
    "downloads",
]  # ask to quit when multiple tabs are open

# @COMPLETIONS
c.completion.favorite_paths = ["~/books"]  # Paths of filesystem to show
c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "history",
    "filesystem",
]  # Categories to shown in o/O mode
c.completion.height = "30%"  # Height
c.completion.scrollbar.padding = 3  # padding for scrollbar in completions
c.completion.timestamp_format = "%m-%d %I:%M%p"  # timestamp of completions

# @Searchs
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "!gh": "https://github.com/search?o=desc&q={}&s=stars",
    "!yt": "https://www.youtube.com/results?search_query={}",
}

# @PRIVACY:Content
c.content.autoplay = False  # starts playing video automatically
c.content.blocking.enabled = True
c.content.blocking.method = "adblock"
c.content.cookies.accept = "no-3rdparty"
c.content.canvas_reading = False
c.content.headers.referer = "same-domain"
c.content.default_encoding = "utf-8"
c.content.desktop_capture = True
c.content.geolocation = "ask"
c.content.javascript.clipboard = "access"
c.content.prefers_reduced_motion = False
c.content.pdfjs = True

# @Insert mode
c.input.insert_mode.auto_load = True

# @Messages
c.messages.timeout = 2000

# @Downloads
c.downloads.location.suggestion = "both"
c.downloads.remove_finished = 3000

# @Scrolling
c.scrolling.smooth = True
