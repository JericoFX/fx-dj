fx_version 'cerulean'
games {'gta5'}
 
description 'Jerico Tool to stop printing crap on the console, this is not the final version is just a Developer tool (Thanks to Kakarot!)'
name 'fx-Tools'
version 'V1'



server_scripts {
    'config.lua',
    'server/server.lua'
}

client_scripts {
    'config.lua',
    'client/main.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/script.js',
    'html/css/*.css'
   -- 'html/css/reset.css'
}

