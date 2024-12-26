visible = 0

function init()
	SetValue("visible", 1.0, "cosine", 0.5)
end

function tick()
	--Put a scripting menu button on the pause menu for all levels, except the main menu
	if not string.find(GetString("game.levelpath"), "MOD/main.xml") then
		if PauseMenuButton("Vida Hospital Menu") then
			StartLevel("", "MOD/main.xml")
		end
	end
end
