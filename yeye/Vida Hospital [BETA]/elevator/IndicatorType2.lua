function tick()	
	screen = UiGetScreen()
    carID = GetTagValue(screen, "CarID")
end

function draw()
	if screen == 0 then
		return
	end	
	UiTranslate(0, 0)
	UiImage("MOD/elevator/indicatorscreen.png")
	if GetBool("level.EV"..carID.."IsOn") == true then
	UiAlign("center middle")
	local currentFloor = GetString("level.EV"..carID.."flr")
	UiFont("MOD/elevator/DisplayFont.ttf", 80)
	UiColor(1.0, 0.0, 0.0)
	UiTranslate(75, 50)
	if GetBool("level.EV"..carID.."INS") == false and GetBool("level.EV"..carID.."FIRE") == false then
		UiText(currentFloor)
	elseif GetBool("level.EV"..carID.."FIRE")==true then
		UiText("FE")
	elseif GetBool("level.EV"..carID.."INS")==true then
		UiText("INS")
	end
	end
end