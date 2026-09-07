-- Hyprland default apps

TERMINAL     = "kitty"
TERMINAL2    = "ghostty"
FILE_MANAGER = "dolphin"
-- BROWSER      = "zen-browser"
-- BROWSER      = "/usr/bin/google-chrome-stable %U"
BROWSER      = "python .local/bin/browser_selector.py"
INCOGNITO    = "zen-browser --private-window"
EDITOR       = "vscodium"
CALCULATOR   = "gnome-calculator"
KEYBINDINGS  = "python ~/.local/bin/keybindings.py"
PDFVIEWER    = "okular"
MAIL         = "thunderbird"

-- PWA
INSTAGRAM    = "/opt/google/chrome/google-chrome --password-store=basic --profile-directory=Default --app-id=akpamiohjfcnimfljfndmaldlcfphjmp"
FACEBOOK     = "/opt/google/chrome/google-chrome --password-store=basic --profile-directory=Default --app-id=kippjfofjhjlffjecoapiogbkgbpmgej"

-- Monitors
MONITOR1 = ""
MONITOR2 = ""
MONITOR3 = ""
PRIMARY_MONITOR = MONITOR1

-- Workspaces
NUM_WPM = 5 -- Number of workspaces per monitor (Max 10)
