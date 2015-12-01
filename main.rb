require "gosu"
require_relative 'z_order'
require_relative 'player'

class Window < Gosu::Window

	def initialize
		super 480,480
		self.caption = "Final Game"

		@background_image = Gosu::Image.new("images/space.jpg")

		@player = Player.new
		@player.warp(width/2.0, (height/2.0) + height / 2.5)

		@bg_x = 0
		@bg_y = 0
	end

	def draw
		@player.draw
		draw_backgrounds
	end

	def draw_backgrounds
		@backgrounds = 0
		while @backgrounds <= 100
			@background_image.draw(@bg_x, @bg_y, ZOrder::BACKGROUND)
			@backgrounds += 1
			@bg_x += 402
			@bg_y += 402
		end
		while @backgrounds > 100 && @backgrounds <= 200
			@background_image.draw(@bg_x, @bg_y, ZOrder::BACKGROUND)
			@backgrounds += 1
			@bg_x -= 402
			@bg_y -= 402
		end
	end

end

window = Window.new
window.show