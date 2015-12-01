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
	end

	def draw
		@player.draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
	end

end

window = Window.new
window.show