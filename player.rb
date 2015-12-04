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

	def direction_up
		if @angle < 180.0
			@angle += 10.0
			if @angle == 180.0
				@angle = 180.0
			end
		elsif @angle > 180.0
			@angle -= 10.0
			if @angle == 180.0
				@angle = 180.0
			end
		end
	end

	def direction_right
		if @angle < 270.0
			@angle += 10.0
			if @angle == 270.0
				@angle = 270.0
			end
		elsif @angle > 270.0
			@angle -= 10.0
			if @angle == 270.0
				@angle = 270.0
			end
		end
	end

	def direction_down
		if @angle <= 180.0
			if @angle != 0.0
				@angle -= 10.0
			end
			if @angle == 0.0
				@angle = 0.0
			end
		elsif @angle > 180.0
			if @angle != 360.0
				@angle += 10.0
			end
			if @angle == 360.0
				@angle = 360.0
			end
		end
	end

	def direction_left
		if @angle < 90.0
			@angle += 10.0
			if @angle == 90.0
				@angle = 90.0
			end
		elsif @angle > 90.0
			@angle -= 10.0
			if @angle == 90.0
				@angle = 90.0
			end
		end
	end

end