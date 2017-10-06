Class = require "class"
require "bullet"

Player = Class()

function Player:init(x, y)
	self.x = x
	self.y = y
	self.health = 100

	self.width = 50
	self.height = 100
end

function Player:draw()
	love.graphics.setColor(0, 255, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end


function Player:update(dt)
	local dx = 0
	if love.keyboard.isDown("a") then
		dx = -1
	end
	if love.keyboard.isDown("d") then
		dx = dx + 1
	end
	self.x = self.x + dx * dt * 200

	local dy = 0
	if love.keyboard.isDown("w") then
		dy = -1
	end
	if love.keyboard.isDown("s") then
		dy = dy + 1
	end
	self.y = self.y + dy * dt * 200


	if love.mouse.isDown(1) then
		local f = math.atan2(love.mouse.getY()-self.y, love.mouse.getX()-self.x)
		local b = Bullet(self.x, self.y, f)
		table.insert(bullets, b)
	end
end