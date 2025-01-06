luaDebugMode = true
local videoPath
function onCreate()
    -- background shit
    
    makeLuaSprite('flash', '', 0, 0);
    makeGraphic('flash', 1280, 720, '000000')
    setObjectCamera('flash', 'hud')
    addLuaSprite('flash', false)

    setProperty('flash.alpha', 1)

end
function onCreatePost()
    setProperty('healthbarUnder.visible', false)
    setProperty('healthbackground.visible', false)
    setProperty('iconP1.alpha', 0)
    setProperty('iconP2.alpha', 0)

    setProperty('songLength.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('healthbarOver.visible', false)
    setProperty('bg.visible', false)
end

function onStepHit()

    if curStep == 1 then
      --startVideo('1')
      makeVideoSprite('ever', '1', 0, 0, 'hud')
      --bla.makeVideoSprite('ever','1',0,0,'camHUD')
        for i = 0, 3 do
            noteTweenAlpha(i + 4, i + 4, 0, 1, 'quartInOut')
            noteTweenAlpha(i, i, 0, 1, 'quartInOut')
        end
    end

    if curStep == 5 then setProperty('flash.alpha', 0) end

    if curStep == 129 then
        cameraFlash('other', 'FFFFFF', 1, true)
        for i = 0, 3 do

            noteTweenAlpha(i + 4, i + 4, 1, 1, 'quartInOut')
            noteTweenAlpha(i, i, 1, 1, 'quartInOut')

            setProperty('timeBarBG.visible', true)
            setProperty('timeBar.visible', true)
            setProperty('songLength.visible', true)
            setProperty('scoreTxt.visible', true)
        end

    end

    if curStep == 246 then doTweenAlpha('flash', 'flash', 1, 0.5) end

    if curStep == 253 then
        makeVideoSprite('evert','2',0,0,'camHUD')
        setProperty('flash.visible', false)
        for i = 0, 3 do

            noteTweenAlpha(i + 4, i + 4, 0.5, 1, 'quartInOut')
            noteTweenAlpha(i, i, 0.5, 1, 'quartInOut')

        end
    end

    if curStep == 257 then end
    if curStep == 288 then
        setProperty('iconP1.alpha', 1)
        setProperty('iconP2.alpha', 1)
        setProperty('scoreTxt.alpha', 1)
        setProperty('healthbarOver.visible', true)
        setProperty('healthbarUnder.visible', true)
        setProperty('healthbackground.visible', true)
        setProperty('bg.visible', true)
        for i = 0, 3 do

            noteTweenAlpha(i + 4, i + 4, 1, 1, 'quartInOut')
            noteTweenAlpha(i, i, 1, 1, 'quartInOut')

        end
    end
end

