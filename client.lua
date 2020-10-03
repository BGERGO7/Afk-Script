--Feladatok: getTickCount-tal megcsinalni

local nextCheckTime = 1000
local oX, oY, oZ = nil, nil, nil
local isAfk = false
local afkSec = 0
local afkMin = 0

local sx,sy = guiGetScreenSize()

function isAFK()
	local pX, pY, pZ = getElementPosition(localPlayer)

	if isAfk == false then
		afkSec = afkSec + 1

		showChat(true)								
		setPlayerHudComponentVisible("all",true)	

		if afkSec == 60 then
			afkSec = 0
			afkMin = afkMin + 1
		end
	end 

	if afkMin == 3 then 
		isAfk = true
	end

	if afkMin == 20 then
		triggerServerEvent("onPlayerAfkKick",getRootElement(), "afk")
	end 

	if isAfk == true then
		if oX then                                          
			if pX == oX and pY == oY and pZ == oZ then      
				isAfk = true
				showChat(false)
				countingTime()							
				setPlayerHudComponentVisible("all",false)								
			else                                           
				isAfk = false								
				showChat(true)								
				setPlayerHudComponentVisible("all",true)	
				outputChatBox("nem afk")
				afkMin = 0
				afkSec = 0	
			end
		end

	end
	
	oX, oY, oZ = pX, pY, pZ								
end

function countingTime()
	afkSec = afkSec + 1

	if afkSec == 60 then
		afkSec = 0
		afkMin = afkMin + 1
	end
end

function drawAfk()
	if isAfk == true then 
		dxDrawRectangle(sx*0, sy*0, sx*1, sy*1, tocolor(64,64,64,160) )
		dxDrawText("Jelenleg AFK vagy!",sx*0.26,sy*0.3,sx,sy, tocolor(255,255,255), 4, "pricedown")
		dxDrawText("Ha szeretnél játszott perceket és fizetést, akkor lépj vissza!",sx*0.125,sy*0.6,sx,sy, tocolor(255,255,255), 2, "pricedown")

		if afkSec <= 9 and afkMin <= 9 then 
			dxDrawText("0"..afkMin..":0"..afkSec,sx*0.43,sy*0.9,sx,sy, tocolor(255,255,255), 4, "pricedown")
		
		elseif afkSec > 9 and afkMin <= 9 then 
			dxDrawText("0"..afkMin..":"..afkSec,sx*0.43,sy*0.9,sx,sy, tocolor(255,255,255), 4, "pricedown")
		
		elseif afkMin <= 9 then
			dxDrawText(""..afkMin..":0"..afkSec,sx*0.43,sy*0.9,sx,sy, tocolor(255,255,255), 4, "pricedown")
		end 
	end
end

addEventHandler("onClientRender", getRootElement(), drawAfk)

					 
setTimer(isAFK, nextCheckTime, 0) 