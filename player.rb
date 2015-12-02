require "gosu"
require_relative 'z_order'

class Player

	def initialize(x, y, angle)
		@x = @y
		@y = y
		@angle = angle
		@score = 0
		@image = Gosu::Image.new("images/ship.png")
	end

	def warp(x, y)
		@x, @y = x, y
	end

	def draw
		@image.draw_rot(@x, @y, ZOrder::PLAYER, @angle)
	end

end