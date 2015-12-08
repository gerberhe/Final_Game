require "gosu"
require_relative 'z_order'

class Obstacle
	attr_reader :x, :y

	def initialize(type, x, y, dir)
		@type = type
		@obstacle = Gosu::Image.new("images/obstacle.jpg")
		@x = x
		@y = y
		@direction = dir
	end

	def draw
		if @type == 0
			@obstacle.draw(@x, @y, ZOrder::OBSTACLE)
			@y += 3
		elsif @type == 1
			@obstacle.draw_rot(@x, @y, ZOrder::OBSTACLE, 90)
			@x -= 3
		elsif @type == 2
			@obstacle.draw(@x, @y, ZOrder::OBSTACLE)
			@y -= 3
		elsif @type == 3
			@obstacle.draw_rot(@x, @y, ZOrder::OBSTACLE, -90)
			@x += 3
		end
	end

	def get_x
		@x
	end

	def get_y
		@y
	end

	def direction
		@direction
	end

end