--Made my spectradev on discord
luaDebugMode = true
-- {songName , {p1IconX,p1IconY} , {p2IconX,p2IconY} , {healthbarXdownscroll,healthbarYdownscroll} , {healthbarXupscroll,healthbarYupscroll} , {innerBarX,innerBarY} , framerate , flipped}
local BarData = {
    {'Booyah', --its literaly the song name, fuck you
    {0,0}, --p1 icon shit
    {0,0}, --p2 icon shit
    {0,0}, --healthcare downscroll shit
    {0,0}, --same as above but upscroll
    {0,0}, --inner bar shit
    24, --framerate, what are you, a dumbass?
    false --if its flipped or not
    }
}
function onCreate() --change values inside of here if youve changed the base healthbar
    iconX1 = 0 --player 1 icon x offset
    iconY1 = 0 --player 1 icon y offset
    iconX2 = 0 --player 2 icon x offset
    iconY2 = 0 --player 2 icon y offset
    downscrollX = 0 --healthbar downscroll x offset
    downscrollY = 0 --healthbar downscroll y offset
    upscrollX = 0 --healthbar upscroll x offset
    upscrollY = -50 --healthbar upscroll y offset
    innerBarX = 0 --sex
    innerBarY = 0 --you get it
    fps = 24 --standard fnf framerate
    flipped = false --flipped healthbar
    setSettings()
end
--you shouldnt have to change anything below here, fuck off, dipshit
function onCreatePost()
    if checkFileExists("images/customHealthbars/"..string.lower(songName).."/player.png", false) then --better image detection! :3
        barImageDirectory = string.lower(songName)..'/'
    else
        barImageDirectory = ""
    end
    makeAnimatedLuaSprite('bg',"customHealthbars/"..barImageDirectory..'fireBar',0, 0)
	addAnimationByPrefix('bg','shit','Healthbar0',12,true)
	addLuaSprite("bg", false)
    setObjectCamera("bg", "camHUD")
    
    makeLuaSprite("healthbarUnder", "customHealthbars/"..barImageDirectory..'player', 0.0, 0.0) --healthbar bottom (player if not flipped)
    addLuaSprite("healthbarUnder", false)
    setObjectCamera("healthbarUnder", "camHUD")
    
    setProperty("healthbarUnder.color", getColorFromHex("FF0000"))

    makeLuaSprite("healthbarOver", "customHealthbars/"..barImageDirectory..'opponent', 0.0, 0.0) --healthbar top (opponent if not flipped)
    addLuaSprite("healthbarOver", false)
    setObjectCamera("healthbarOver", "camHUD")
    setObjectOrder("healthbarOver", getObjectOrder("healthbarUnder")+1)
    makeLuaSprite("healthbackground", "customHealthbars/"..barImageDirectory..'healthBarBG', 0.0, 0.0) --BG
    addLuaSprite("healthbackground", false)
    setObjectCamera("healthbackground", "camHUD")
    
    --setters time
    screenCenter("healthbackground", 'x')
    if downscroll then
        setProperty('healthbackground.y',60)
        setRel('healthbackground.x',downscrollX)
        setRel('healthbackground.y',downscrollY)
        setRel('bg.x',downscrollX)
        setRel('bg.y',downscrollY)
    else
        setProperty('healthbackground.y',720-60)
        setRel('healthbackground.x',upscrollX)
        setRel('healthbackground.y',upscrollY)
        setRel('bg.x',upscrollX + 310)
        setRel('bg.y',upscrollY + 320)
    end
    
    
    setProperty("healthbarUnder.x", getProperty("healthbackground.x")+getMid('healthbackground.width')-getMid('healthbarUnder.width')+innerBarX)
    setProperty("healthbarUnder.y", getProperty("healthbackground.y")+getMid('healthbackground.height')-getMid('healthbarUnder.height')+innerBarY)
    setProperty("healthbarOver.x", getProperty("healthbarUnder.x"))
    setProperty("healthbarOver.y", getProperty("healthbarUnder.y"))
    setProperty("flasher.x", getProperty("healthbarOver.x"))
    setProperty("flasher.y", getProperty("healthbarOver.y"))
    defaultWidth = getProperty("healthbarOver.width")
    if flipped then
        setProperty('iconP1.flipX',true)
        setProperty('iconP2.flipX',true)
        setFrame('healthbarOver','width',defaultWidth*(getHealth()/2))
        setProperty("healthbarUnder.color", getColorFromHex(dadColor()))
        setProperty("healthbarOver.color", getColorFromHex(bfColor()))
    else
        setFrame('healthbarOver','width',defaultWidth-(defaultWidth*(getHealth()/2)))
        setProperty("healthbarUnder.color", getColorFromHex(bfColor()))
        setProperty("healthbarOver.color", getColorFromHex(dadColor()))
    end
    originalP1height = getProperty("iconP1.height")
    originalP2height = getProperty("iconP2.height")
    setProperty("healthBar.visible", false)
    setProperty("healthBarBG.visible", false)
end
local timeFunny = 10
function onUpdatePost(elapsed)

    setProperty("iconP2.y", getProperty('healthbarOver.y')+(getProperty("iconP2.height")/10)-(originalP2height/2)+iconY2)
    setProperty("iconP1.y", getProperty('healthbarOver.y')+(getProperty("iconP1.height")/10)-(originalP1height/2)+iconY1)
    if flipped then
        setProperty('flasher.color',getProperty("healthbarOver.color"))
        if getFrame('healthbarOver','width') > defaultWidth-2 then
            setProperty("healthbarUnder.alpha", 0)
            setProperty("flasher.visible", true)
        else
            setProperty("healthbarUnder.alpha", 1)
            setProperty("flasher.visible", false)
        end

        setProperty("iconP2.x", getProperty('healthbarOver.x')+getFrame('healthbarOver','width')+((getProperty("iconP2.width")/2)-100)+iconX2)
        setProperty("iconP1.x", getProperty('healthbarOver.x')+getFrame('healthbarOver','width')-((getProperty("iconP1.width")/2)+60)+iconX1)

        if getFrame('healthbarOver','width') > (defaultWidth*(getHealth()/2))-2 and getFrame('healthbarOver','width') < (defaultWidth*(getHealth()/2))+2 then
        elseif getFrame('healthbarOver','width') > (defaultWidth*(getHealth()/2)) then
            setFrame('healthbarOver','width',(getFrame('healthbarOver','width')-(getFrame('healthbarOver','width')-((defaultWidth*(getHealth()/2))))/timeFunny))
        elseif getFrame('healthbarOver','width') < (defaultWidth*(getHealth()/2)) then
            setFrame('healthbarOver','width',(getFrame('healthbarOver','width')+((defaultWidth*(getHealth()/2))-getFrame('healthbarOver','width'))/timeFunny))
        end
    else
        setProperty('flasher.color',getProperty("healthbarUnder.color"))
        if getFrame('healthbarOver','width') < 2 then
            setProperty("healthbarOver.alpha", 0)
            setProperty("flasher.visible", true)
        else
            setProperty("healthbarOver.alpha", 1)
            setProperty("flasher.visible", false)
        end
        setProperty("iconP1.x", getProperty('healthbarOver.x')+getFrame('healthbarOver','width')+((getProperty("iconP1.width")/2)-90)+iconX1)
        setProperty("iconP2.x", getProperty('healthbarOver.x')+getFrame('healthbarOver','width')-((getProperty("iconP2.width")/2)+50)+iconX2)
        if getFrame('healthbarOver','width') > defaultWidth-(defaultWidth*(getHealth()/2))-2 and getFrame('healthbarOver','width') < defaultWidth-(defaultWidth*(getHealth()/2))+2 then
        elseif getFrame('healthbarOver','width') > defaultWidth-(defaultWidth*(getHealth()/2)) then
            setFrame('healthbarOver','width',(getFrame('healthbarOver','width')-(getFrame('healthbarOver','width')-(defaultWidth-(defaultWidth*(getHealth()/2))))/timeFunny))
        elseif getFrame('healthbarOver','width') < defaultWidth-(defaultWidth*(getHealth()/2)) then
            setFrame('healthbarOver','width',(getFrame('healthbarOver','width')+(defaultWidth-(defaultWidth*(getHealth()/2))-getFrame('healthbarOver','width'))/timeFunny))
        end
    end
    
            setProperty('bg.alpha', getHealth() / 2)
end

function onEvent(eventName, value1, value2)
    if eventName == 'Change Character' then
        if flipped then
            doTweenColor('changeColor1','healthbarUnder',dadColor(),0.25,'expoOut')
            doTweenColor('changeColor2','healthbarOver',bfColor(),0.25,'expoOut')
        else
            doTweenColor('changeColor1','healthbarUnder',bfColor(),0.25,'expoOut')
            doTweenColor('changeColor2','healthbarOver',dadColor(),0.25,'expoOut')
        end
    end
end










--helping functions--

function getFrame(tag,type)
    return getProperty(tag..'._frame.frame.'..type)
end
function setFrame(tag,type,value)
    setProperty(tag..'._frame.frame.'..type,value)
end
function getMid(tag)
    return getProperty(tag)/2
end
function setRel(tag,value)
    setProperty(tag, getProperty(tag)+value)
end
function setSettings() --add more stuff to this if youve modified the script with more functions
    for i in pairs(BarData) do
        if BarData[i][1] == songName then
            iconX1 = BarData[i][2][1]
            iconY1 = BarData[i][2][2]
            iconX2 = BarData[i][3][1]
            iconY2 = BarData[i][3][2]
            downscrollX = BarData[i][4][1]
            downscrollY = BarData[i][4][2]
            upscrollX = BarData[i][5][1]
            upscrollY = BarData[i][5][1]
            innerBarX = BarData[i][6][1]
            innerBarY = BarData[i][6][2]
            fps = BarData[i][7]
            flipped = BarData[i][8]
        end
    end
end
function dadColor()
    return rgbToHex(getProperty('dad.healthColorArray'))
end
function bfColor()
    return rgbToHex(getProperty('boyfriend.healthColorArray'))
end
function rgbToHex(rgb) -- https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
    return string.format('%02x%02x%02x', math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end