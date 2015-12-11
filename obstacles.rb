require "gosu"
require_relative 'z_order'
require_relative 'player'

class Obstacle
	attr_reader :x, :y

	def initialize(type, x, y, dir, player, speed, main_gameover)
		@type = type
		@obstacle = Gosu::Image.new("images/obstacle.jpg")
		@arrow = Gosu::Image.new("images/arrow.png")
		@x = x
		@y = y
		@player = player
		@direction = dir

		@movement = speed

		@arrow_dir_num = rand(0..1)

		@main_gameover = main_gameover
	end

	def draw
		if @type == 0
			@obstacle.draw(@x, @y, ZOrder::OBSTACLE)

			if @arrow_dir_num < 0.5 &&
				@arrow.draw(@x, @y - 70, ZOrder::ARROW)
			elsif @arrow_dir_num >= 0.5
				@arrow.draw_rot(@x + 60, @y - 40, ZOrder::ARROW, 180.0)
			end
			@y += @movement

		elsif @type == 1
			@obstacle.draw_rot(@x, @y, ZOrder::OBSTACLE, 90)

			if @arrow_dir_num < 0.5
				@arrow.draw_rot(@x + 70, @y, ZOrder::ARROW, 270.0)
			elsif @arrow_dir_num >= 0.5
				@arrow.draw_rot(@x + 60, @y, ZOrder::ARROW, 90.0)
			end
			@x -= @movement

		elsif @type == 2
			@obstacle.draw(@x, @y, ZOrder::OBSTACLE)

			if @arrow_dir_num < 0.5
				@arrow.draw(@x, @y + 70, ZOrder::ARROW)
			elsif @arrow_dir_num >= 0.5
				@arrow.draw_rot(@x + 70, @y + 90, ZOrder::ARROW, 180.0)
			end
			@y -= @movement

		elsif @type == 3
			@obstacle.draw_rot(@x, @y, ZOrder::OBSTACLE, -90)

			if @arrow_dir_num < 0.5
				@arrow.draw_rot(@x - 70, @y, ZOrder::ARROW, 90.0)
			elsif @arrow_dir_num >= 0.5
				@arrow.draw_rot(@x - 60, @y, ZOrder::ARROW, 270.0)
			end
			@x += @movement

		end
		no_movement
	end

	def get_x
		@x
	end

	def get_y
		@y
	end

	def arrow_dir
		@arrow_dir_num
	end

	def direction
		@direction
	end

	def no_movement
		if @player.game_over? == 1 || @main_gameover == 1
			@movement = 0
		end
	end

end