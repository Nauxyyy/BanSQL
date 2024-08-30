fx_version 'adamant'
game 'gta5'

author 'Nauxyy'
title 'Ban SQL'
description 'The ban sql the most famous but rework by Nauxyy'
version '1.1.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/function.lua',
	'server/main.lua'
}

client_scripts {
  'client.lua'
}

dependencies {
	'essentialmode',
	'async'
}
