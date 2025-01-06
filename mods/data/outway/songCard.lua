-- entire script made by fyrid

cardimage = 'songCard' -- your image name
duration = 1.2 -- time it appears for
stayTime = 3 -- time it stays for
ease = 'circIn' -- tween ease for when it leaves
textfont = 'vcr.ttf' -- song card text font
composername = 'Color' -- song creator goes here
composerCards = false

function onCreate()
    makeLuaSprite('songCardSprite', cardimage, 0, 150)
    addLuaSprite('songCardSprite', true)
    
    makeLuaText('songNameTxt', songName, 0, 0, 150)
    setTextFont('songNameTxt', textfont)
    setTextSize('songNameTxt', 72)
    addLuaText('songNameTxt')

    makeLuaText('composerNameTxt', 'Composer(s) - ' .. composername, 0, 0, 218)
    
    setTextSize('composerNameTxt', 24)
    addLuaText('composerNameTxt')

    setObjectCamera('songCardSprite', 'other')
    setObjectCamera('songNameTxt', 'other')
    setObjectCamera('composerNameTxt', 'other')

    runTimer('cardTimer', stayTime, 1)
end


function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'cardTimer' then
        songCardLeave()
    end
end

function songCardLeave()
    doTweenX('cardTween', 'songCardSprite', -1000, duration, ease)
    doTweenX('cardTween2', 'songNameTxt', -1000, duration, ease)
    doTweenX('cardTween3', 'composerNameTxt', -1000, duration, ease)
end