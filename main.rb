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

		@temp = 0

		@direction = 0
		@background = Gosu::Image.new("images/space.jpg")
		@background2 = Gosu::Image.new("images/space.jpg")
	end

	def draw
		@player.draw
		draw_backgrounds
	end

	def update
		if Gosu::button_down? Gosu::KbUp
			@direction = 0 
			@temp = 0
		end
		if Gosu::button_down? Gosu::KbRight
			@direction = 1 
			@temp = 0
		end
		if Gosu::button_down? Gosu::KbDown
			@direction = 2 
			@temp = 0
		end
		if Gosu::button_down? Gosu::KbLeft
			@direction = 3 
			@temp = 0
		end
	end

	def draw_backgrounds		
		if @direction == 0
			moving_down
			if @temp == 0
				@obstacle = Obstacle.new(0, 165, -100, 0)
				@temp = 1
			end
			@obstacle.draw
		elsif @direction == 1
			moving_right
			if @temp == 0
				@obstacle = Obstacle.new(1, 600, 240, 1)
				@temp = 1
			end
			@obstacle.draw
		elsif @direction == 2
			moving_up
			if @temp == 0
				@obstacle = Obstacle.new(2, 165, 600, 2)
				@temp = 1
			end
			@obstacle.draw
		elsif @direction == 3
			moving_left
			if @temp == 0
				@obstacle = Obstacle.new(3, -100, 240, 3)
				@temp = 1
			end
			@obstacle.draw
		end
		collision
	end

	def collision
		@player.colliding?(@obstacle)
		if @player.game_over? == 1
			abort
		end
	end

	def moving_down
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