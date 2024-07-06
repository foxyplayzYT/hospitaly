function init()
	snd = false
	vehicle = FindVehicle()
	siren = LoadLoop("MOD/sound/LF1.ogg", 100.0)
end

function draw()
	if InputPressed("f") then
		if GetPlayerVehicle() == vehicle then
		 	if snd == false then
				snd = true
			else
				snd = false
			end
		end
	end
	
	if snd and GetPlayerVehicle() == vehicle then
	    PlayLoop(siren, GetPlayerPos(), 0.5)
	end	
	
end