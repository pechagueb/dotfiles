-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

hl.on("hyprland.start", function ()

    -- Importar todas las variables de sesión (WAYLAND_DISPLAY, XDG_RUNTIME_DIR, etc.) a systemd
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")

    hl.exec_cmd("noctalia")
    hl.exec_cmd("xhost +SI:localuser:root")

    -- Reiniciar el servicio ya con las variables del entorno gráfico cargadas
    hl.exec_cmd("sh -c 'sleep 2 && systemctl --user restart voxtype.service'")

    -- Otras aplicaciones
    hl.exec_cmd("sh -c 'sleep 3 && zapzap'")
    hl.exec_cmd("sh -c 'sleep 5 && cachy-update --tray'")
    hl.exec_cmd("sh -c 'mega-cmd-server > /dev/null 2>&1 &'")

end)
