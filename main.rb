require "gosu"
require_relative 'z_order'
require_relative 'player'
require_relative 'obstacles'

class Window < Gosu::Window

	def initialize
		super 480,480
		self.caption = "Final Game"

		@player = Player.new(0, 0, 180.0)
		@player.warp(width/2.0, height/2.0)

		@bg_x = 0
		@bg_y = 0

		@up_bg_y = -480
		@down_bg_y = 480

		@right_bg_x = 480
		@left_bg_x = -480

		@direction = 0
		@background = Gosu::Image.new("images/space.jpg")
		@background2 = Gosu::Image.new("images/space.jpg")
	end

	def draw
		@player.draw
		draw_backgrounds
	end

	def update
		@direction = 0 if Gosu::button_down? Gosu::KbUp
		@direction = 1 if Gosu::button_down? Gosu::KbRight
		@direction = 2 if Gosu::button_down? Gosu::KbDown
		@direction = 3 if Gosu::button_down? Gosu::KbLeft
	end

	def draw_backgrounds		
		if @direction == 0
			moving_down
		elsif @direction == 1
			moving_right
		elsif @direction == 2
			moving_up
		elsif @direction == 3
			moving_left
		end
	end

	def moving_down
		@obstacle = Obstacle.new(0)
		@obstacle.draw
		@player.direction_up
		@bg_x = 0
		@background.draw(@bg_x, @bg_y, ZOrder::BACKGROUND)
		@background2.draw(@bg_x, @up_bg_y, ZOrder::BACKGROUND)
		if @up_bg_y == 0
				@bg_y = -480
			end
			if @bg_y == 0
				@up_bg_y = -480
			end
			@bg_y += 5
			@up_bg_y += 5
	end

	def moving_right
		@obstacle = Obstacle.new(1)
		@player.direction_right
		@bg_y = 0
		@background.draw(@bg_x, @bg_y, ZOrder::BACKGROUND)
		@background2.draw(@right_bg_x, @bg_y, ZOrder::BACKGROUND)
		if @right_bg_x == 0
			@bg_x = 480
		end
		if @bg_x == 0
			@right_bg_x = 480
		end
		@bg_x -= 5
		@right_bg_x -= 5
	end

	def moving_up
		@obstacle = Obstacle.new(2)
		@player.direction_down
		@bg_x = 0
		@background.draw(@bg_x, @bg_y, ZOrder::BACKGROUND)
		@background2.draw(@bg_x, @up_bg_y, ZOrder::BACKGROUND)
		if @up_bg_y == 0
				@bg_y = 480
			end
			if @bg_y == 0
				@up_bg_y = 480
			end
			@bg_y -= 5
			@up_bg_y -= 5
	end

	def moving_left
		@obstacle = Obstacle.new(3)
		@player.direction_left
		@bg_y = 0
		@background.draw(@bg_x, @bg_y, ZOrder::BACKGROUND)
		@background2.draw(@right_bg_x, @bg_y, ZOrder::BACKGROUND)
		if @right_bg_x == 0
			@bg_x = -480
		end
		if @bg_x == 0
			@right_bg_x = -480
		end
		@bg_x += 5
		@right_bg_x += 5
	end

end

window = Window.new
window.show