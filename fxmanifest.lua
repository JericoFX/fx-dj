fx_version 'cerulean'
games {'gta5'}
 
description 'just a normal DJ script no much funcionality'
name 'fx-dj'
version 'V1'
shared_script { 
	'config.lua',
}


server_scripts {

    'config.lua',
   'server/server.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    'config.lua',
   'client/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/script.js',
    'html/css/*.css'
}
dependence {
    "xsound"
}

