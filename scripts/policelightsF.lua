function init()
	lights = FindShapes("blink")
	pLights = false
	vehicle = FindVehicle()
end

function draw()
if GetPlayerVehicle() == vehicle then
		local info = {}
		info[#info+1] = {"F", "Lights"}
		UiPush()
			UiAlign("top left")
			local w = 200
			local h = #info*22 + 30
			UiTranslate(20, UiHeight()-h-20)
			UiColor(0,0,0,0.5)
			UiImageBox("common/box-solid-6.png", 250, h, 6, 6)
			UiTranslate(100, 32)
			UiColor(1,1,1)
			for i=1, #info do
				local key = info[i][1]
				local func = info[i][2]
				UiFont("bold.ttf", 22)
				UiAlign("right")
				UiText(key)
				UiTranslate(10, 0)
				UiFont("regular.ttf", 22)
				UiAlign("left")
				UiText(func)
				UiTranslate(-10, 22)
			end
		UiPop()
	end
	if InputPressed("f") then
		if GetPlayerVehicle() == vehicle then
		 	if pLights == false then
				pLights = true
			else
				pLights = false
			end
		end
	end
	if pLights then
		for i=1, #lights do
			local l = lights[i]
			local p = tonumber(GetTagValue(l, "blink"))
			if p then
				local s = math.sin((GetTime()+i) * p)
				SetShapeEmissiveScale(l, s > 0 and 1 or 0)
			end
		end
	else
		for i=1, #lights do
			SetShapeEmissiveScale(lights[i], 0 > 0 and 1 or 0)
		end
	end
end


