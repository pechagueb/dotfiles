-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

hl.on("hyprland.start", function ()

    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("noctalia")
    hl.exec_cmd("xhost +SI:localuser:root")

    -- Aplicaciones en segundo plano con sus respectivos delays procesados por shell
    hl.exec_cmd("sh -c 'sleep 3 && zapzap'")

    -- Iniciar el servidor de MEGA de forma silenciosa en el arranque
    hl.exec_cmd("sh -c 'mega-cmd-server > /dev/null 2>&1 &'")

end)

