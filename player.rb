require "gosu"
require_relative 'z_order'

class Player

	def initialize(x, y, angle)
		@x = @y
		@y = y
		@angle = angle
		@score = 0
		@image = Gosu::Image.new("images/ship.png")
		@game_over = 0
	end

	def warp(x, y)
		@x, @y = x, y
	end

	def score
		@score
	end

	def draw
		@image.draw_rot(@x, @y, ZOrder::PLAYER, @angle)
	end

	def direction_up
		if @game_over == 0
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
	end

	def direction_right
		if @game_over == 0
			if @angle == 0.0
				@angle = 360.0
			end
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
	end

	def direction_down
		if @game_over == 0
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
					@angle = 0.0
				end
			end
		end
	end

	def direction_left
		if @game_over == 0
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

	def colliding?(obstacle)
		if obstacle.direction == 0
			if @y <= obstacle.get_y + 75
				@game_over = 1
			end
		elsif obstacle.direction == 1
			if @x >= obstacle.get_x - 50
				@game_over = 1
			end
		elsif obstacle.direction == 2
			if @y >= obstacle.get_y - 30
				@game_over = 1
			end
		elsif obstacle.direction == 3
			if @x <= obstacle.get_x + 50
				@game_over = 1
			end
		end
	end

	def set_game_over(num)
		@game_over = num
	end

	def game_over
		@game_over
	end

end