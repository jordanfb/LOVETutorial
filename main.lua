require "player"

player = Player()

function love.load(args)
	--
end

function love.update(dt)
	player:update(dt)
end

function love.draw()
	player:draw()
end

function love.keypressed(key, unicode)
	--
end

function love.mousepressed(x, y, button)
	--
end