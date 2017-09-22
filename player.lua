--[[
A simple player class that is controlled via keyboard and mouse
Some obvious problems:
- you walk faster diagonally than straight
]]--

Class = require "class"

Player = Class{}


function Player:init(health)
	self.health = health or 100
	self.speed = 100
	self.x = 0
	self.y = 0

	self.color = {200, 255, 100, 255} -- if you don't have the fourth number it defaults to 255 alpha
	self.width = 100
	self.height = 200
end

function Player:update(dt)
	local boolVal = {[true] = 1, [false] = 0}
	-- the square brackets around the boolean values signify that they are the keys
	-- for strings you could just type them in there like t = { hello = 5 }, but if you wanted it to start with a
	-- control character you may have to do the following: t = { [.weird] = false }

	local dx = boolVal[love.keyboard.isDown("d")] - boolVal[love.keyboard.isDown("a")]
	local dy = boolVal[love.keyboard.isDown("s")] - boolVal[love.keyboard.isDown("w")]
	self.x = self.x + dx * self.speed * dt -- make sure you use dt (delta time) to ensure you move the same
	self.y = self.y + dy * self.speed * dt -- speed no matter the framerate
end

function Player:draw()
	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill", self.x - self.width/2, self.y - self.height/2, self.width, self.height)
end