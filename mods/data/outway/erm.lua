local defaultX = 6
local defaultBlur = 0.8
local defaultY = 6
local defaultAngle = -25
local defaultZoom = 1
local si = false
function onCreatePost()
if shadersEnabled then

shaderCoordFix()
initLuaShader('Bloom')
initLuaShader('white')
initLuaShader('vcr')
initLuaShader('glitchthing')
initLuaShader('Elastic')
initLuaShader('desaturate')
initLuaShader("chromabber")
initLuaShader('MirrorRepeatEffect')
initLuaShader('blend')
initLuaShader('2')

makeLuaSprite('eee','SOY UN eeeeeeHUATE',0,0)
makeLuaSprite('bbb','SOY UN eeeeeeHUATE',0,0)
makeLuaSprite('bbb2','SOY UN eeeeeeHUATE',0,0)
makeLuaSprite('bbb3','SOY UN eeeeeeHUATE',0,0)
makeLuaSprite('iiii','SOY UN eeeeeeHUATE',0,0)

makeLuaSprite('Bloom')
makeGraphic('Bloom', screenWidth, screenHeight);
makeLuaSprite('2')
makeGraphic('2', screenWidth, screenHeight);
makeLuaSprite('ay')
makeGraphic('ay', screenWidth, screenHeight);
makeLuaSprite('vcr')
makeGraphic('vcr', screenWidth, screenHeight);
makeLuaSprite('blend')
makeGraphic('blend', screenWidth, screenHeight);
makeLuaSprite('Glitch2')
makeGraphic('Glitch2', screenWidth, screenHeight);
makeLuaSprite('Elas')
makeGraphic('Elas', screenWidth, screenHeight);
makeLuaSprite('desaturate')
makeGraphic('desaturate', screenWidth, screenHeight);
makeLuaSprite("Shader")
setSpriteShader("Shader", "chromabber")
setSpriteShader("blend", "blend")
setSpriteShader("desaturate", "desaturate")
setSpriteShader("ay", "white")

setSpriteShader('Elas', 'Elastic')
setSpriteShader('2', '2')
setSpriteShader('Bloom', 'Bloom')
setSpriteShader('vcr', 'vcr')
setSpriteShader('Glitch2', 'glitchthing')
setShaderFloat('Glitch2','glitchMinimizer',5.0)
setShaderFloat('Glitch2','glitchNarrowness',0)
setShaderFloat('Glitch2','glitchBlockiness',0)
setShaderFloat('Glitch2','glitchAmplitude',0.2)
setProperty('iiii.x',15)

makeLuaSprite('mirror',nil,0,0)
setProperty('mirror.angle',0)
setSpriteShader('mirror', 'MirrorRepeatEffect')

makeLuaSprite('mirrorZoom',nil,1,nil)

addHaxeLibrary('ShaderFilter', 'openfl.filters')



setShaderFloat('Glitch2','intensity',0)
setProperty('iiii.x',0)

setShaderFloat("Shader", "amount", -0.2)
setShaderFloat('Bloom','strength',0)
setShaderFloat('Bloom','effect',0)
setShaderFloat('Bloom','contrast',0)
setShaderFloat('Bloom','brightness',0)
setProperty('bbb.x',0)
setProperty('bbb2.x',0)
setProperty('bbb3.x',0)

setShaderFloat('Elas', 'amount', 0)
setProperty('eee.x',0)

end
setProperty('culo.alpha', 0.8)
setProperty('bgmo.visible', false)
end

function onUpdate()
if shadersEnabled then
    setShaderFloat('Elas', 'amount', getProperty('eee.x'))
    setShaderFloat('Bloom','strength',getProperty('bbb2.x'))
    setShaderFloat('Bloom','effect',getProperty('bbb.x'))
    setShaderFloat('Bloom','brightness',getProperty('bbb3.x'))
    
    setShaderFloat('Glitch2','glitchAmplitude',getProperty('iiii.x'))
    setShaderFloat('Glitch2','glitchMinimizer',getProperty('iiii.x') - 1)
	setShaderFloat('mirror', 'x', getProperty('mirror.x'))
	setShaderFloat('mirror', 'y', getProperty('mirror.y'))
	setShaderFloat('mirror', 'angle', getProperty('mirror.angle'))
	setShaderFloat('mirror', 'zoom', getProperty('mirrorZoom.x'))
	setShaderFloat('Glitch2','iTime',os.clock())
	setShaderFloat('ay','iTime',os.clock())
	setShaderFloat('2','iTime',os.clock())
end
end
speed = 30

function onEvent(n,v1,v2)
if shadersEnabled then
if n == 'MirrorY' then
doTweenY('mY','mirror',v1,v2,'cubeOut')
elseif n == 'MirrorX' then
doTweenX('mX','mirror',v1,v2,'cubeOut')
elseif n == 'MirrorAngle' then
doTweenAngle('mA','mirror',v1,v2,'cubeOut')
elseif n == 'MirrorZoom' then
doTweenX('mZ','mirrorZoom',v1,v2,'cubeOut')
elseif n == 'Elastic' then
setProperty('eee.x',v1)
doTweenX('eee','eee',0,v2)
elseif n == 'Flash50' or n == 'flashwhite' then
Bloom()
end

end
end

function onStepHit()
if curStep == 288 then
   cameraFlash('other', 'FFFFFF', 1, true)
   setProperty('culo.alpha', 0)
   
runHaxeCode([[
trace(ShaderFilter);
game.camGame.setFilters([new ShaderFilter(game.getLuaObject('mirror').shader),new ShaderFilter(game.getLuaObject('Elas').shader),new ShaderFilter(game.getLuaObject('Bloom').shader),new ShaderFilter(game.getLuaObject('Glitch2').shader),new ShaderFilter(game.getLuaObject('vcr').shader),new ShaderFilter(game.getLuaObject("blend").shader)]);
game.camHUD.setFilters([new ShaderFilter(game.getLuaObject('Bloom').shader),new ShaderFilter(game.getLuaObject('Glitch2').shader),new ShaderFilter(game.getLuaObject("Shader").shader)]);
]])
	end
	
	if curStep == 1104 then
	cameraFlash('other', '000000', 1, true)
	runHaxeCode([[
	trace(ShaderFilter);
game.camGame.setFilters([new ShaderFilter(game.getLuaObject('desaturate').shader), new ShaderFilter(game.getLuaObject('2').shader)]);
game.camHUD.setFilters([new ShaderFilter(game.getLuaObject('desaturate').shader), new ShaderFilter(game.getLuaObject('2').shader)]);
	]])
	setProperty('healthbarOver.visible', false)
   setProperty('bg.visible', false)
   setProperty('gf.visible', true)
   setProperty('healthbarUnder.visible', false)
   setProperty('healthbackground.alpha', 0)
   setProperty('iconP1.alpha', 0)
   setProperty('iconP2.alpha', 0)
   setProperty('scoreTxt.alpha', 0)
	end
	
	if curStep == 1328 then
   cameraFlash('other', 'FFFFFF', 1, true)
   
   setProperty('bg.visible', true)
   
   setProperty('gf.visible', false)
   setProperty('iconP1.alpha', 1)
   setProperty('iconP2.alpha', 1)
   setProperty('scoreTxt.alpha', 1)
   setProperty('healthbarOver.visible', true)
   setProperty('healthbarUnder.visible', true)
   
   runHaxeCode([[
trace(ShaderFilter);
game.camGame.setFilters([new ShaderFilter(game.getLuaObject('mirror').shader),new ShaderFilter(game.getLuaObject('Elas').shader),new ShaderFilter(game.getLuaObject('Bloom').shader),new ShaderFilter(game.getLuaObject('Glitch2').shader),new ShaderFilter(game.getLuaObject('vcr').shader),new ShaderFilter(game.getLuaObject("blend").shader)]);
game.camHUD.setFilters([new ShaderFilter(game.getLuaObject('Bloom').shader),new ShaderFilter(game.getLuaObject('Glitch2').shader),new ShaderFilter(game.getLuaObject("Shader").shader)]);
]])

	end
	if curStep == 1755 then
	si = true
	end
	if curStep == 1760 then
	   setProperty('bgmo.visible', true)
	setProperty('city.color', '000000')
	setProperty('street.color', '000000')
	
	runHaxeCode([[
trace(ShaderFilter);
game.camGame.setFilters([new ShaderFilter(game.getLuaObject('mirror').shader),new ShaderFilter(game.getLuaObject('Elas').shader),new ShaderFilter(game.getLuaObject('Bloom').shader),new ShaderFilter(game.getLuaObject('Glitch2').shader),new ShaderFilter(game.getLuaObject('vcr').shader),new ShaderFilter(game.getLuaObject("ay").shader)]);
game.camHUD.setFilters([new ShaderFilter(game.getLuaObject('Bloom').shader),new ShaderFilter(game.getLuaObject('Glitch2').shader),new ShaderFilter(game.getLuaObject("Shader").shader)]);
]])
setProperty('aymipene.alpha', 1)

    end
     
    
    if curStep == 1904 then
	   setProperty('bgmo.visible', false)
	runHaxeCode([[
trace(ShaderFilter); 
game.camGame.setFilters([new ShaderFilter(game.getLuaObject('mirror').shader),new ShaderFilter(game.getLuaObject('Elas').shader),new ShaderFilter(game.getLuaObject('Bloom').shader),new ShaderFilter(game.getLuaObject('Glitch2').shader),new ShaderFilter(game.getLuaObject('vcr').shader),new ShaderFilter(game.getLuaObject("blend").shader)]);
game.camHUD.setFilters([new ShaderFilter(game.getLuaObject('Bloom').shader),new ShaderFilter(game.getLuaObject('Glitch2').shader),new ShaderFilter(game.getLuaObject("Shader").shader)]);
]])
setProperty('city.color', 'FFFFFF')
	setProperty('street.color', 'FFFFFF')
	
	setProperty('aymipene.alpha', 0)
	doTweenColor('jdjdjd', 'city', 'FFFFFF', 0.000005, 'linear')
		doTweenColor('djdjjd', 'street', 'FFFFFF', 0.000005, 'linear')
	for i = 0,f do
	removeLuaText('part'.. i)
	removeLuaText('part2'.. i)
	end
	si = false
    end
    if curStep % 8 == 0 and si == true then
		letras2()
    letras()
	end
    
end








local palabras = {'Let us recover your world', 'The Salvation is Near', "Lets us show you.", "Thousands of souls", "The Moon is near.", "We can't escape from our fate.", "Its worth to let go.", "THE DEAREST.", "Our revenge will rise", "You don't understand.", "Where is HIM?"}

f = 0
function letras()
	
        songPos = getSongPosition()
        currentBeat = (songPos/500)
        f = f + 1
        sus = math.random(2, 1500)
        sus2 = math.random(2, 1500)
        sus3 = math.random(2, 1500)
        makeLuaText('part' .. f, '', 1000, 1000, math.random(2, 1500))
        setTextString('part'..f, palabras[getRandomInt(1, #palabras)])
        setTextColor('part'.. f, 'FF00AA')
        setTextSize('part'.. f, 30)
        
		
            addLuaText('part' .. f, true)
         doTweenX('part'..f, 'part'..f, -2000, math.random(10, 20))
		   
        if f >= 150 then
            f = 1
        end
	
end

function letras2()
	
        songPos = getSongPosition()
        currentBeat = (songPos/500)
        f = f + 1
        sus = math.random(2, 1500)
        sus2 = math.random(2, 1500)
        sus3 = math.random(2, 1500)
        makeLuaText('part2' .. f, '', 1000, -1000, math.random(2, 1500))
        setTextString('part2'..f, palabras[getRandomInt(1, #palabras)])
        
		setTextColor('part2'.. f, 'FF00AA')
            
            setTextSize('part2'.. f, 30)
         
         addLuaText('part2' .. f, true)
         
         
		   doTweenX('ay'..f, 'part2'..f, 2000, math.random(10, 20))
        if f >= 150 then
            f = 1
        end
	
end

function Bloom()
    setProperty('bbb.x',1.5)
    setProperty('bbb3.x',1)
    setProperty('bbb2.x',0.4)
    doTweenX('hgjkon','bbb',0,2)
    doTweenX('hgjkn','bbb2',0,2)
    doTweenX('hgjn','bbb3',0,2)
    setProperty('iiii.x',4)
    doTweenX('hgn','iiii',15,5,'circOut')
    end
    function onGameOverStart()
    doTweenX('hgjkon','bbb',0,0.3)
    doTweenX('hgjkn','bbb2',0,0.3)
    doTweenX('hgjn','bbb3',0,0.3)
    doTweenX('hgn','iiii',0,0.3,'circOut')
    runTimer('to',3.9)
    end
function shaderCoordFix()
if shadersEnabled then
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }
        
        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }
    
        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
        return;
    ]])
    
    local temp = onDestroy
    function onDestroy()
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
            return;
        ]])
        if (temp) then temp() end
    end
end
end