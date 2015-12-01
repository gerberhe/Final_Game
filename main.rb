require "gosu"
require_relative 'z_order'

class Window < Gosu::Window

	def initialize
		super 480,480
		self.caption = "Final Game"

		@background_image = Gosu::Image.new("images/space.jpg")
	end

	def draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
	end

end

window = Window.new
window.show