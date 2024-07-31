fx_version 'adamant'
games { 'gta5' }

author 'xdnation'
description 'Bodycam System made for QBCore FiveM servers'
version '1.0'
ui_page "nui/index.html"

dependencies {
    'qb-core',
    'qb-management'
}

files {
    "nui/index.html",
    "nui/vue.min.js",
    "nui/script.js",
    "nui/style.css",
    "nui/images/seal.png",
    "html/sounds/*.ogg"
}

client_scripts {
    "client/bodycam.lua",
    "client/gopro.lua"
}

server_scripts {
    "server/server.lua"
}


lua54 'yes'
