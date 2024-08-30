Text               = {}
BanList            = {}
BanListLoad        = false
BanListHistory     = {}
BanListHistoryLoad = false
if Config.Lang == "fr" then Text = Config.TextFr elseif Config.Lang == "en" then Text = Config.TextEn else print("FIveM-BanSql : Invalid Config.Lang") end

local discordInviteLink = Config.discord

CreateThread(function()
	while true do
		Wait(1000)
        if BanListLoad == false then
			loadBanList()
			if BanList ~= {} then
				print(Text.banlistloaded)
				BanListLoad = true
			else
				print(Text.starterror)
			end
		end
		if BanListHistoryLoad == false then
			loadBanListHistory()
            if BanListHistory ~= {} then
				print(Text.historyloaded)
				BanListHistoryLoad = true
			else
				print(Text.starterror)
			end
		end
	end
end)

CreateThread(function()
	while Config.MultiServerSync do
		Wait(30000)
		MySQL.Async.fetchAll(
		'SELECT * FROM banlist',
		{},
		function (data)
			if #data ~= #BanList then
			  BanList = {}

			  for i=1, #data, 1 do
				table.insert(BanList, {
					license    = data[i].license,
					identifier = data[i].identifier,
					liveid     = data[i].liveid,
					xblid      = data[i].xblid,
					discord    = data[i].discord,
					playerip   = data[i].playerip,
					reason     = data[i].reason,
					added      = data[i].added,
					expiration = data[i].expiration,
					permanent  = data[i].permanent,
					sourceplayername = data[i].sourceplayername,
					targetplayername = data[i].targetplayername,
					debutban   = data[i].debutban
				  })
			  end
			loadBanListHistory()
			TriggerClientEvent('BanSql:Respond', -1)
			end
		end
		)
	end
end)

function loadBanList()
    MySQL.Async.fetchAll('SELECT * FROM banlist', {}, function(data)
        if data and #data > 0 then
            BanList = {}
            for i = 1, #data do
                local entry = data[i]
                table.insert(BanList, {
                    license        = entry.license or "n/a",
                    identifier     = entry.identifier or "n/a",
                    liveid         = entry.liveid or "n/a",
                    xblid          = entry.xblid or "n/a",
                    discord        = entry.discord or "n/a",
                    playerip       = entry.playerip or "n/a",
                    reason         = entry.reason or "Aucune raison fournie",
                    added          = entry.added or 0,
                    expiration     = entry.expiration or 0,
                    permanent      = entry.permanent or 0,
                    sourceplayername = entry.sourceplayername or "Inconnu",
					targetplayername = entry.targetplayername or "Inconnu",
					debutban       = entry.debutban or "n/a"
                })
            end
            BanListLoad = true
        else
            print(Text.starterror)
        end
    end)
end

-- Load ban list all 30 sec
CreateThread(function()
    while true do
        Wait(30000)  
        loadBanList()  
    end
end)

RegisterCommand("ban", function(source, args, raw)
	if source == 0 then
		cmdban(source, args)
	end
end, true)

RegisterCommand("unban", function(source, args, raw)
	if source == 0 then
		cmdunban(source, args)
	end
end, true)


RegisterCommand("search", function(source, args, raw)
	if source == 0 then
		cmdsearch(source, args)
	end
end, true)

RegisterCommand("banoffline", function(source, args, raw)
	if source == 0 then
		cmdbanoffline(source, args)
	end
end, true)

RegisterCommand("banhistory", function(source, args, raw)
	if source == 0 then
		cmdbanhistory(source, args)
	end
end, true)


TriggerEvent('es:addGroupCommand', 'sqlban', Config.Permission, function (source, args, user)
	cmdban(source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.ban, params = {{name = "id"}, {name = "day", help = Text.dayhelp}, {name = "reason", help = Text.reason}}})

TriggerEvent('es:addGroupCommand', 'sqlunban', Config.Permission, function (source, args, user)
	cmdunban(source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.unban, params = {{name = "name", help = Text.steamname}}})

TriggerEvent('es:addGroupCommand', 'sqlsearch', Config.Permission, function (source, args, user)
	cmdsearch(source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.bansearch, params = {{name = "name", help = Text.steamname}}})

TriggerEvent('es:addGroupCommand', 'sqlbanoffline', Config.Permission, function (source, args, user)
	cmdbanoffline(source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.banoff, params = {{name = "permid", help = Text.permid}, {name = "day", help = Text.dayhelp}, {name = "reason", help = Text.reason}}})

TriggerEvent('es:addGroupCommand', 'sqlbanhistory', Config.Permission, function (source, args, user)
	cmdbanhistory(source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.history, params = {{name = "name", help = Text.steamname}, }})

TriggerEvent('es:addGroupCommand', 'sqlbanreload', Config.Permission, function (source)
  BanListLoad        = false
  BanListHistoryLoad = false
  Wait(5000)
  if BanListLoad == true then
	TriggerEvent('bansql:sendMessage', source, Text.banlistloaded)
	if BanListHistoryLoad == true then
		TriggerEvent('bansql:sendMessage', source, Text.historyloaded)
	end
  else
	TriggerEvent('bansql:sendMessage', source, Text.loaderror)
  end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.reload})


RegisterServerEvent('BanSql:ICheat')
AddEventHandler('BanSql:ICheat', function(reason,servertarget)
	local license,identifier,liveid,xblid,discord,playerip,target
	local duree     = 0
	local reason    = reason

	if not reason then reason = "Auto Anti-Cheat" end

	if tostring(source) == "" then
		target = tonumber(servertarget)
	else
		target = source
	end

	if target and target > 0 then
		local ping = GetPlayerPing(target)
	
		if ping and ping > 0 then
			if duree and duree < 365 then
				local sourceplayername = "Anti-Cheat-System"
				local targetplayername = GetPlayerName(target)
					for k,v in ipairs(GetPlayerIdentifiers(target))do
						if string.sub(v, 1, string.len("license:")) == "license:" then
							license = v
						elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
							identifier = v
						elseif string.sub(v, 1, string.len("live:")) == "live:" then
							liveid = v
						elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
							xblid  = v
						elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
							discord = v
						elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
							playerip = v
						end
					end
			
				if duree > 0 then
					ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,0) 
					DropPlayer(target, Text.yourban .. reason)
				else
					ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1)
					DropPlayer(target, Text.yourpermban .. reason)
				end
			
			else
				print("BanSql Error : Auto-Cheat-Ban time invalid.")
			end	
		else
			print("BanSql Error : Auto-Cheat-Ban target are not online.")
		end
	else
		print("BanSql Error : Auto-Cheat-Ban have recive invalid id.")
	end
end)

RegisterServerEvent('BanSql:CheckMe')
AddEventHandler('BanSql:CheckMe', function()
	doublecheck(source)
end)


AddEventHandler('bansql:sendMessage', function(source, message)
	if source ~= 0 then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1Banlist ', message } } )
	else
		print('SqlBan: ' .. message)
	end
end)

AddEventHandler('playerConnecting', function(playerName, setKickReason)
    local license, steamID, liveid, xblid, discord, playerip = "n/a", "n/a", "n/a", "n/a", "n/a", "n/a"


    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamID = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xblid = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            playerip = v
        end
    end


    if #BanList == 0 then
        Citizen.Wait(1000) 
    end

    local foundBan = false
    for i = 1, #BanList do
        local ban = BanList[i]
        local expirationTimestamp = tonumber(ban.expiration) or 0

        if (tostring(ban.license) == tostring(license)
            or tostring(ban.identifier) == tostring(steamID)
            or tostring(ban.liveid) == tostring(liveid)
            or tostring(ban.xblid) == tostring(xblid)
            or tostring(ban.discord) == tostring(discord)
            or tostring(ban.playerip) == tostring(playerip)) then

            if tonumber(ban.permanent) == 1 then
				-- Perm ban
                local kickReason = "\n\n" .. Text.yourpermban .. "\n\n" ..
                Text.date .. formatTimestamp(ban.debutban) .. "\n" ..
                Text.by .. (ban.sourceplayername or "Inconnu") .. "\n" ..
                Text.reason .. (ban.reason or Text.noreason) .. "\n" ..
                Text.yourname .. (ban.targetplayername or "Inconnu") .. "\n\n" ..
                Text.discordtext .. discordInviteLink

                setKickReason(kickReason)
                CancelEvent()
                foundBan = true
                break

				
            elseif formatTimestamp(expirationTimestamp) < osTimeTimestamp(Config.GMTOffset) and tonumber(ban.permanent) == 0 then
                -- ban expire
                deletebanned(ban.license)

            elseif expirationTimestamp > os.time() then
                -- ban
                local tempsrestant = expirationTimestamp - os.time()
                local joursrestants = math.floor((tempsrestant % 216000) / 86400)
                local heuresrestantes = math.floor((tempsrestant % 86400) / 3600)
                local minutesrestantes = math.floor((tempsrestant % 3600) / 60)

                local kickReason = "\n\n" .. Text.yourban .. "\n\n" ..
                Text.date .. formatTimestamp(ban.debutban) .. "\n" ..
                Text.by .. (ban.sourceplayername or "Inconnu") .. "\n" ..
                Text.reason .. (ban.reason or Text.noreason) .. "\n" ..
                Text.yourname .. (ban.targetplayername or "Inconnu") .. "\n\n" ..
                Text.datedeban .. "\n" ..
                formatTimestamp(expirationTimestamp)

                kickReason = kickReason .. "\n\n" ..
                Text.discordtext .. discordInviteLink

                setKickReason(kickReason)
                CancelEvent()
                foundBan = true
                break
            end
        end
    end

    if not foundBan and Config.ForceSteam and steamID == "n/a" then
        setKickReason(Text.invalidsteam)
        CancelEvent()
    end
end)

AddEventHandler('es:playerLoaded', function(source)
    CreateThread(function()
        Wait(5000)
        local license, steamID, liveid, xblid, discord, playerip
        local playername = GetPlayerName(source)

        for k, v in ipairs(GetPlayerIdentifiers(source)) do
            if string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamID = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xblid = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                playerip = v
            end
        end

        MySQL.Async.fetchAll('SELECT * FROM `baninfo` WHERE `license` = @license', {
            ['@license'] = license
        }, function(data)
            local found = false
            for i = 1, #data, 1 do
                if data[i].license == license then
                    found = true
                end
            end
            if not found then
                MySQL.Async.execute('INSERT INTO baninfo (license,identifier,liveid,xblid,discord,playerip,playername) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@playername)', 
                { 
                    ['@license']    = license,
                    ['@identifier'] = steamID,
                    ['@liveid']     = liveid,
                    ['@xblid']      = xblid,
                    ['@discord']    = discord,
                    ['@playerip']   = playerip,
                    ['@playername'] = playername
                },
                function ()
                end)
            else
                MySQL.Async.execute('UPDATE `baninfo` SET `identifier` = @identifier, `liveid` = @liveid, `xblid` = @xblid, `discord` = @discord, `playerip` = @playerip, `playername` = @playername WHERE `license` = @license', 
                { 
                    ['@license']    = license,
                    ['@identifier'] = steamID,
                    ['@liveid']     = liveid,
                    ['@xblid']      = xblid,
                    ['@discord']    = discord,
                    ['@playerip']   = playerip,
                    ['@playername'] = playername
                },
                function ()
                end)
            end
        end)
        if Config.MultiServerSync then
            doublecheck(source)
        end
    end)
end)
