require "gosu"
require_relative 'z_order'
require_relative 'player'

class Window < Gosu::Window

	def initialize
		super 480,480
		self.caption = "Final Game"

		@player = Player.new(0, 0, 180.0)
		@player.warp(width/2.0, (height/2.0) + height / 2.5)

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
	end

	def draw_backgrounds		
		if @direction == 0
			moving_down
		elsif @direction == 1
			moving_right
		elsif @direction == 2

		elsif @direction == 3

		end
	end

	def determine_angle
		if @direction == 0
			180.0
		elsif @direction == 1

		elsif @direction == 2

		elsif @direction == 3

		end
	end

	def moving_down
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

end

window = Window.new
window.show