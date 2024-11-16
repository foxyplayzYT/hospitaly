-- Define a variable to track the button state
local menuMainPressed = false
local button15State = "1st"
local button16State = "2nd"
local button17State = "3rd"
local button18State = "4th"
local button20State = "5th"
local button22State = "6th"
local button24State = "7th"
local button25State = "8th"
local button26State = "unused"
local button27State = "unused"
local button28State = "unused"
local buttonGASState = "unused"
local buttonTRAState = "trees"
local buttonliftState = "liftoff"
local buttonHolState = "lights"
local buttonUTLState = "vehicles"
local buttongateState = "gates"

function draw()
    UiImage("MOD/Script/menu-main.png")

    UiMakeInteractive()
    UiButtonHoverColor(.7, .7, .7)

    UiPush()
    UiAlign("center middle")
    UiScale(1)
    UiFont("bold.ttf", 100)

    UiTranslate(UiCenter() - -300, 200)
    UiPush()
    UiText("Vida Hospital")
    UiPop()

    UiTranslate(-1250, -100)

    UiPush()
    UiAlign("left")

    UiColor(0, 0, 0, 0.7)
    UiRect(540, 600, 0, 0)
    UiTranslate(30, 30)
    UiColor(1, 1, 1, 1)
    UiScale(.25)

    -- Button for main map
    if UiImageButton("MOD/Script/menu-2025.png") then
        -- Toggle the state
        menuMainPressed = not menuMainPressed
    end
    UiTranslate(900, 1000)
    UiAlign("center middle")
    UiText("Vida Hospital - Press here to play")
    UiTranslate(0, 200)
    UiText("Map By: FoxyPlayzYT, Mr.Random")
    UiAlign("left")
    UiTranslate(-900, 200)
    UiText("Very Special Thanks To:")
    UiTranslate(0, 100)
    UiText("Menu by Salad Fries!")
    UiTranslate(0, 100)
    UiText("Caffeine Power-ALS")
    UiTranslate(0, 100)
    UiText("Winter - Trees Pack MOD")
    UiTranslate(0, 100)
    UiText("YuLun - Sectional Garage Door MOD")
    UiTranslate(0, 100)
    UiText("WAY2GO - Bright Valley Correctional Center MOD")
    UiTranslate(0, -1900)

    -- Configure menu
    if menuMainPressed then
        UiPush()
        UiAlign("left")

        UiScale(4)
        UiTranslate(550, -30)

        UiColor(0, 0, 0, 0.7)
        UiRect(1050, 600, 0, 0)
        UiTranslate(30, 30)
        UiColor(1, 1, 1, 1)

        UiScale(.125)

        -- 1st floor button with toggle functionality
        UiImage("MOD/Script/menu-15.png")
        UiTranslate(0, 800)
        if button15State == "1stoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button15State = "1st"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button15State = "1stoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("1st Floor")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 2nd floor button with toggle functionality
        UiImage("MOD/Script/menu-16.png")
        UiTranslate(0, 800)
        if button16State == "2ndoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button16State = "2nd"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button16State = "2ndoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("2nd Floor")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 3rd floor button with toggle functionality
        UiImage("MOD/Script/menu-17.png")
        UiTranslate(0, 800)
        if button17State == "3rdoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button17State = "3rd"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button17State = "3rdoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("3rd Floor")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 4th floor button with toggle functionality
        UiImage("MOD/Script/menu-18.png")
        UiTranslate(0, 800)
        if button18State == "4thoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button18State = "4th"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button18State = "4thoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("4th Floor")
        UiScale(.25)
        UiTranslate(-6000, 550)

        -- 5th floor button with toggle functionality
        UiImage("MOD/Script/menu-20.png")
        UiTranslate(0, 800)
        if button20State == "5thoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button20State = "5th"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button20State = "5thoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("5th Floor")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 6th floor button with toggle functionality
        UiImage("MOD/Script/menu-22.png")
        UiTranslate(0, 800)
        if button22State == "6thoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button22State = "6th"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button22State = "6thoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("6th Floor")
        UiScale(.25)
        UiTranslate(2000, -750)


        -- 7th floor button with toggle functionality
        UiImage("MOD/Script/menu-24.png")
        UiTranslate(0, 800)
        if button24State == "7thoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button24State = "7th"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button24State = "7thoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("7th Floor")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 8th floor button with toggle functionality
        UiImage("MOD/Script/menu-25.png")
        UiTranslate(0, 800)
        if button25State == "8thoff" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button25State = "8th"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button25State = "8thoff"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("8th Floor")
        UiScale(.25)
        UiTranslate(-6000, 550)

        -- 26 button with toggle functionality
        UiImage("MOD/Script/menu-26.png")
        UiTranslate(0, 800)
        if button26State == "26Unfurnished" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button26State = "26Furniture"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button26State = "26Unfurnished"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("26")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 27 button with toggle functionality
        UiImage("MOD/Script/menu-27.png")
        UiTranslate(0, 800)
        if button27State == "27Unfurnished" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button27State = "27Furniture"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button27State = "27Unfurnished"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("27")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- 28 button with toggle functionality
        UiImage("MOD/Script/menu-28.png")
        UiTranslate(0, 800)
        if button28State == "28Unfurnished" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                button28State = "28Furniture"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                button28State = "28Unfurnished"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("28")
        UiScale(.25)
        UiTranslate(2000, -750)

        -- GAS button with toggle functionality
        UiImage("MOD/Script/menu-GAS.png")
        UiTranslate(0, 800)
        if buttonGASState == "GASUnfurnished" then
            if UiImageButton("MOD/Script/ToggleUnFurnished.png") then
                buttonGASState = "GASFurniture"
            end
        else
            if UiImageButton("MOD/Script/ToggleFurnished.png") then
                buttonGASState = "GASUnfurnished"
            end
        end
        UiTranslate(0,-50)
        UiScale(4)
        UiText("GAS")
        UiScale(.25)
        UiTranslate(600, 600)

        -- Holiday button with toggle functionality
        UiScale(2)
        UiText("Gates")
        UiScale(.66)
        UiTranslate(0, 100)
        UiColor(.8, .8, .8, 1)
        UiText("Toggles Ambulance Gates")
        UiTranslate(0, 100)
        UiText("Possibly reduces lag")
        UiTranslate(0, 50)
        UiScale(1.5151)
        UiScale(.25)
        UiColor(1, 1, 1, 1)
        if buttongateState == "gatesoff" then
            if UiImageButton("MOD/Script/ToggleOff.png") then
                buttongateState = "gates"
            end
        else
            if UiImageButton("MOD/Script/ToggleOn.png") then
                buttongateState = "gatesoff"
            end
        end
        UiTranslate(-2600, -660)

        -- elevators button with toggle functionality
        UiScale(4)
        UiText("Elevators")
        UiScale(.66)
        UiTranslate(0, 100)
        UiColor(.8, .8, .8, 1)
        UiText("Toggles 3 Elevators")
        UiTranslate(0, 100)
        UiText("Keeping OFF reduces lag")
        UiTranslate(0, 50)
        UiScale(1.5151)
        UiScale(.25)
        UiColor(1, 1, 1, 1)
        if buttonliftState == "liftoff" then
            if UiImageButton("MOD/Script/ToggleOn.png") then
                buttonliftState = "lift"
            end
        else
            if UiImageButton("MOD/Script/ToggleOff.png") then
                buttonliftState = "liftoff"
            end
        end
        UiTranslate(-2600, -660)

        -- Pole button with toggle functionality
        UiScale(4)
        UiText("Vehicles")
        UiScale(.66)
        UiTranslate(0, 100)
        UiColor(.8, .8, .8, 1)
        UiText("Toggles every vehicle")
        UiTranslate(0, 100)
        UiText("Possibly reduces lag")
        UiTranslate(0, 50)
        UiScale(1.5151)
        UiScale(.25)
        UiColor(1, 1, 1, 1)
        if buttonUTLState == "vehiclesoff" then
            if UiImageButton("MOD/Script/ToggleOff.png") then
                buttonUTLState = "vehicles"
            end
        else
            if UiImageButton("MOD/Script/ToggleOn.png") then
                buttonUTLState = "vehiclesoff"
            end
        end
        UiTranslate(-2600, -660)

        -- Traffic Light button with toggle functionality
        UiScale(4)
        UiText("Trees")
        UiScale(.66)
        UiTranslate(0, 100)
        UiColor(.8, .8, .8, 1)
        UiText("Toggles the Trees")
        UiTranslate(0, 100)
        UiText("Possibly reduces lag")
        UiTranslate(0, 50)
        UiScale(1.5151)
        UiScale(.25)
        UiColor(1, 1, 1, 1)
        if buttonTRAState == "treesoff" then
            if UiImageButton("MOD/Script/ToggleOff.png") then
                buttonTRAState = "trees"
            end
        else
            if UiImageButton("MOD/Script/ToggleOn.png") then
                buttonTRAState = "treesoff"
            end
        end
        UiScale(2)
        UiTranslate(-2600, -400)

        if UiImageButton("MOD/Script/menu-Start.png") then
            StartLevel("", "MOD/map.xml", "byounds " .. button15State .. " " .. button16State .. " " .. button17State .. " " .. button18State .. " " .. button20State .. " " .. button22State .. " " .. button24State .. " " .. button25State .. " " .. button26State .. " " .. button27State .. " " .. button28State .. " " .. buttonGASState .. " " .. buttonTRAState .. " " .. buttonliftState .. " " .. buttonHolState .. "  " .. buttonUTLState .. " " .. buttongateState .. " 15Finish 16Finish 17Finish 18Finish 20Finish 22Finish 24Finish 24Addition 25Finish 26Finish 27Finish 28Finish Quest")
        end

        UiPop()
    end

    UiPop()


end
