fx_version 'cerulean'
game 'gta5'

author 'Ben Yasher'
description 'Old School Fight System - نظام قتال أصلي كلاسيكي'
version '1.0.0'

lua54 'yes'

client_scripts {
    'client/main.lua',
    'client/combat.lua',
    'client/animations.lua',
    'client/ui.lua'
}

server_scripts {
    'server/main.lua',
    'server/events.lua'
}

shared_scripts {
    'shared/config.lua',
    'shared/combos.lua'
}
