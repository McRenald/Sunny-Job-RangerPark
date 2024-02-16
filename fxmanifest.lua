fx_version "cerulean"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

description "Sunny RangerPark Job"
version "0.0.1"

shared_script {
	"shared/config.lua",
	"shared/functions.lua"
}

server_script {
	"server/server.lua"
}

client_script {
	"client/client.lua",
	"client/commands.lua",
	"client/events.lua",
}

dependencies {
	"qbr-core",
	"qbr-inventory",
	"progressbar",
}

lua54 "yes"
