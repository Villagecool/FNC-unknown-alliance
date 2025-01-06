
function onCreatePost()
   
  luaDebugMode = true
  setProperty('gf.visible', false)
  makeLuaSprite('culo', '', -800, -800)
    makeGraphic('culo', 4000, 4000, '000000')
	addLuaSprite('culo', false);
  setProperty('culo.alpha', 0.8)
  
end


