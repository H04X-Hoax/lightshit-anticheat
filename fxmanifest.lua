fx_version 'cerulean'
game 'gta5'

author 'ImoShield On Top'
description 'Buy ImoShield'
version '1.0.0'

lua54 'yes'

client_script {

    "client/client.lua",
    "config/client_config.lua",
    "config/server_webhooks.lua"

}

server_script {

    "server/server.lua",
    "config/server_config.lua",
    "config/server_webhooks.lua"

}

ui_page 'index.html'

files {
    'index.html',
    'onworddetection.js'
}

escrow_ignore {
    'config/client_config.lua',
    'config/server_config.lua',
    'config/server_webhooks.lua'
}
dependency '/assetpacks'
dependency '/assetpacks'