fx_version "cerulean"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

description "Sunny RangerPark Job"
version "0.0.1"

shared_scripts {
	"shared/config.lua",
	"shared/functions.lua"
}

server_scripts {
	"server/server.lua"
}

client_scripts {
	"client/client.lua",
	"client/commands.lua",
	"client/events.lua",
	"client/functions.lua",
}

ui_page 'ui/build/index.html'
files {
	'ui/build/index.html',
	'ui/build/**/*'
}

dependencies {
	"qbr-core",
	"qbr-inventory",
	"progressbar",
}

lua54 "yes"
