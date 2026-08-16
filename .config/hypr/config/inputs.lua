-- Input configuration

hl.config({
    input = {

        -- Distribución de tu teclado (es = España, latam = Latinoamérica, us = EE.UU.)
        kb_layout = "es", 
    
        -- Tasa de repetición al mantener presionada una tecla
        repeat_rate = 20,
        repeat_delay = 500,

        -- Puntero
        -- sensitivity = -0.25,
        accel_profile = "flat",
    },
    -- Uncomment the section below to enable software cursors; this can help with cursor display or behavior issues
    -- cursor = {
    --     no_hardware_cursors = 1,
    -- },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down",       action = "close" })
hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left",       action = "float" })
