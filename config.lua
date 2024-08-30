Config                   = {}

--GENERAL
Config.Lang              = 'en'    --Set lang (fr-en)
Config.Permission        = "superadmin" --Permission need to use FiveM-BanSql commands (mod-admin-superadmin)
Config.ForceSteam        = true    --Set to false if you not use steam auth
Config.MultiServerSync   = true   
Config.discord           = "https://discord.gg/TpjEmdxBJ5" -- Ur discord
Config.GMTOffset         = 2 -- Ur GMT


--WEBHOOK
Config.EnableDiscordLink = true --Turn this true if you want link the log to a discord (true-false)
Config.webhookban        = "https://discord.com/api/webhooks/1265671993974591630/B_jUL3Hh3keF5DLkLhWgEtrO2Yb39vUfmDpX9p_THONxIHKs2nALRRzb09fAEswPfc2m"
Config.webhookunban      = "https://discord.com/api/webhooks/1265671993974591630/B_jUL3Hh3keF5DLkLhWgEtrO2Yb39vUfmDpX9p_THONxIHKs2nALRRzb09fAEswPfc2m"


--LANGUAGE
Config.TextFr = {
	start         = "La BanList et l'historique a ete charger avec succes",
	starterror    = "ERREUR : La BanList ou l'historique n'a pas ete charger nouvelle tentative.",
	banlistloaded = "La BanList a ete charger avec succes.",
	historyloaded = "La BanListHistory a ete charger avec succes.",
	loaderror     = "ERREUR : La BanList n a pas été charger.",
	cmdban        = "/sqlban (ID) (Durée en jours) (Raison)",
	cmdbanoff     = "/sqlbanoffline (Permid) (Durée en jours) (Raison)",
	cmdhistory    = "/sqlbanhistory (Steam name) ou /sqlbanhistory 1,2,2,4......",
	noreason      = "Raison Inconnue",
	during        = " pendant : ",
	noresult      = "Il n'y a pas autant de résultats !",
	isban         = " a été ban",
	isunban       = " a été déban",
	invalidsteam  =  "Vous devriez ouvrir steam",
	invalidid     = "ID du joueur incorrect",
	invalidname   = "Le nom n'est pas valide",
	invalidtime   = "Duree du ban incorrecte",
	alreadyban    = " étais déja bannie pour : ",
	yourban       = "** Vous avez été ban de ce serveur **",
	yourpermban   = "** Vous avez été ban permanent de ce serveur **",
	youban        = "Vous avez banni : ",
	forr          = " pour : ",
	permban       = " de facon permanente pour : ",
	timeleft      = "Il reste : ",
	toomanyresult = "Trop de résultats, veillez être plus précis.",
	day           = " Jours ",
	hour          = " Heures ",
	minute        = " Minutes ",
	by            = "Ban par : ",
	ban           = "Bannir un joueurs qui est en ligne",
	banoff        = "Bannir un joueurs qui est hors ligne",
	bansearch     = "Trouver l'id permanent d'un joueur qui est hors ligne",
	dayhelp       = "Nombre de jours",
	reason        = "Raison du ban : ",
	permid        = "Trouver l'id permanent avec la commande (sqlsearch)",
	history       = "Affiche tout les bans d'un joueur",
	reload        = "Recharge la BanList et la BanListHistory",
	unban         = "Retirez un ban de la liste",
	steamname     = "(Nom Steam)",
	date          = "Ban le : ",
	yourname      = "Votre nom de ban est : ",
	datedeban     = "Vous serez unban le : ",
	discordtext   = "Rejoignez notre Discord pour plus d'informations : "
}


Config.TextEn = {
	start         = "BanList and BanListHistory loaded successfully.",
	starterror    = "ERROR: BanList and BanListHistory failed to load, please retry.",
	banlistloaded = "BanList loaded successfully.",
	historyloaded = "BanListHistory loaded successfully.",
	loaderror     = "ERROR: The BanList failed to load.",
	cmdban        = "/sqlban (ID) (Duration in days) (Ban reason)",
	cmdbanoff     = "/sqlbanoffline (Permid) (Duration in days) (Steam name)",
	cmdhistory    = "/sqlbanhistory (Steam name) or /sqlbanhistory 1,2,2,4......",
	forcontinu    = " days. To continue, execute /sqlreason [reason]",
	noreason      = "No reason provided.",
	during        = " during: ",
	noresult      = "No results found.",
	isban         = " was banned",
	isunban       = " was unbanned",
	invalidsteam  = "Steam is required to join this server.",
	invalidid     = "Player ID not found",
	invalidname   = "The specified name is not valid",
	invalidtime   = "Invalid ban duration",
	alreadyban    = " was already banned for : ",
	yourban       = "You have been banned of this server ",
	yourpermban   = "You have been permanently banned of this server ",
	youban        = "You have banned : ",
	forr          = " for : ",
	permban       = " permanently for: ",
	timeleft      = ". Time remaining: ",
	toomanyresult = "Too many results, be more specific to shorten the results.",
	day           = " days ",
	hour          = " hours ",
	minute        = " minutes ",
	by            = "ban by : ",
	ban           = "Ban a player",
	banoff        = "Ban an offline player",
	dayhelp       = "Duration (days) of ban",
	reason        = "Reason for ban : ",
	history       = "Shows all previous bans for a certain player",
	reload        = "Refreshes the ban list and history.",
	unban         = "Unban a player.",
	steamname     = "Steam name",
	date          = "Ban the : ",
	yourname      = "Your banned name is : ",
	datedeban     = "You will be unbanned the : ",
	discordtext   = "Join our Discord for more information : "
}
