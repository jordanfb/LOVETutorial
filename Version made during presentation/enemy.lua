Class = require "class"

Enemy = Class()

function Enemy:init(x, y, player)
	self.x = x
	self.y = y
	self.player = player
	self.speed = 100
	self.width = 50
	self.height = 100
	
	self.health = 100
end

function Enemy:update(dt)
	local f = math.atan2(self.player.y - self.y, self.player.x - self.x)
	self.x = self.x + math.cos(f) * self.speed * dt
	self.y = self.y + math.sin(f) * self.speed * dt
end

function Enemy:draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end