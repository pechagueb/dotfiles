-- Auto-start config
hl.on("hyprland.start", function ()

    -- Importar todas las variables de sesión a systemd
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")

    -- Iniciar daemon de keyring para Chrome/PWAs
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

    hl.exec_cmd("noctalia")
    hl.exec_cmd("xhost +SI:localuser:root")

    -- Reiniciar el servicio ya con las variables del entorno gráfico cargadas
    hl.exec_cmd("sh -c 'sleep 2 && systemctl --user restart voxtype.service'")

    -- Otras aplicaciones
    hl.exec_cmd("sh -c 'sleep 3 && zapzap'")
    hl.exec_cmd("sh -c 'sleep 5 && cachy-update --tray'")
    hl.exec_cmd("sh -c 'mega-cmd-server > /dev/null 2>&1 &'")

    -- Crear monitor virtual headless con un retardo para asegurar que el compositor y los portales estén listos
    -- hl.exec_cmd("sh -c 'sleep 4 && hyprctl output create headless HEADLESS-1'")

end)