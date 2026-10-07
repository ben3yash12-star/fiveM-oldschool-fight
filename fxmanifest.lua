fx_version 'cerulean'
game 'gta5'

author 'بن ياشر - Ben Yasher'
description 'نظام قتال كلاسيكي أصلي - Old School Fight System'
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

escrow_ignore {
    'shared/config.lua',
    'shared/combos.lua',
    'client/main.lua',
    'server/main.lua'
}
