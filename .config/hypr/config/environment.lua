-- Environmental variables
-- if you don't use UWSM, define your variables here (e.g. hl.env("QT_QPA_PLATFORM", "wayland"))

hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("TQT_QPA_PLATFORMTHEME", "qt6ct") -- Para asegurar compatibilidad con Qt6
hl.env("QT_STYLE_OVERRIDE", "kvantum")   -- Fuerza a Qt a delegar el estilo visual en Kvantum
hl.env("GTK_THEME", "Adwaita-dark")

hl.env("EDITOR", "fresh")
