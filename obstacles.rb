require "gosu"

class Obstacle

	def initialize(type)
		@type = type
		@obstacle1 = Gosu::Image.new("images/obstacle1.png")
		@obstacle2 = Gosu::Image.new("images/obstacle2.png")
		@x = @y = 0
	end

	def draw
		if @type == 0
			@x = 240
			@y = -150
			@num = rand(0..1)
			if @num <= 0.5
				@obstacle1.draw(@x, @y, ZOrder::OBSTACLE)
			elsif @num > 0.5 && @num <= 1.0
				@obstacle2.draw(@x, @y, ZOrder::OBSTACLE)
			end
			@obstacle1.draw(@x, @y, ZOrder::OBSTACLE)
			@y += 5
			puts "hello"
		elsif @type == 1

		elsif @type == 2

		elsif @type == 3

		end
	end

end