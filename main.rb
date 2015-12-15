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
		@temp2 = 0

		@bg_move_speed = 5

		@font = Gosu::Font.new(20)
		@end_font = Gosu::Font.new(50)

		@time = 0.0
		@time_up = 0.020

		@obstacle_speed = 3
		@next_speedup = 20.0

		@arrow_direction = 0

		@direction = 0
		@background = Gosu::Image.new("images/space.jpg")
		@background2 = Gosu::Image.new("images/space.jpg")

		@game_over = 0
		@high_score = 0

		@file = File.open("highscore.txt", "r")
		@highscore = @file.read.split("\n")
	end

	def draw
		@player.draw
		draw_backgrounds
		@font.draw("Time Survived: #{@time.to_i}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
		@font.draw("High Score Time Survived: #{@highscore[0].to_i}", 10, 40, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
		if @player.game_over == 1
			@end_font.draw("Game Over!", 120, 210, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
			@font.draw("You Hit a Wall!", 180, 250, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
			@time_up = 0
		end
		if @game_over == 1
			@end_font.draw("Game Over!", 120, 210, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
			@font.draw("You Went the Wrong Direction!", 120, 250, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
			@time_up = 0
		end
	end

	def update
		if @player.game_over == 0 || @game_over == 0
			check_correct_direction
			if @direction != 2
				if @direction == 0
					
				else
					if Gosu::button_down? Gosu::KbUp
						@direction = 0 
						@temp = 0
					end
				end
			end
			if @direction != 3
				if @direction == 1

				else
					if Gosu::button_down? Gosu::KbRight
						@direction = 1 
						@temp = 0
					end
				end
			end
			if @direction != 0
				if @direction == 2
					
				else
					if Gosu::button_down? Gosu::KbDown
						@direction = 2 
						@temp = 0
					end
				end
			end
			if @direction != 1
				if @direction == 3
					
				else
					if Gosu::button_down? Gosu::KbLeft
						@direction = 3 
						@temp = 0
					end
				end
			end
		end

		@time += @time_up

		if @next_speedup >= 100.0
			@obstacle_speed = 8
		elsif @time >= @next_speedup
			@obstacle_speed += 1
			@next_speedup += 20.0
		end

		if @player.game_over == 1 || @game_over == 1
			@high_score = @highscore[0].to_i
			@file2 = File.open("highscore.txt", "w")
			if @time >= @high_score
				@file2.write(@time)
				@file2.close
			end
		end
	end

	def check_correct_direction
		if @direction == 0
			if @temp2 == 1
				@arrow_direction = @obstacle.arrow_dir
				if @arrow_direction < 0.5
					if Gosu::button_down? Gosu::KbLeft
						@game_over = 1
					end
				elsif @arrow_direction >= 0.5
					if Gosu::button_down? Gosu::KbRight
						@game_over = 1
					end
				end
			end
		elsif @direction == 1
			if @temp2 == 1
				@arrow_direction = @obstacle.arrow_dir
				if @arrow_direction < 0.5
					if Gosu::button_down? Gosu::KbDown
						@game_over = 1
					end
				elsif @arrow_direction >= 0.5
					if Gosu::button_down? Gosu::KbUp
						@game_over = 1
					end
				end
			end
		elsif @direction == 2
			if @temp2 == 1
				@arrow_direction = @obstacle.arrow_dir
				if @arrow_direction < 0.5
					if Gosu::button_down? Gosu::KbLeft
						@game_over = 1
					end
				elsif @arrow_direction >= 0.5
					if Gosu::button_down? Gosu::KbRight
						@game_over = 1
					end
				end
			end
		elsif @direction == 3
			if @temp2 == 1
				@arrow_direction = @obstacle.arrow_dir
				if @arrow_direction < 0.5
					if Gosu::button_down? Gosu::KbUp
						@game_over = 1
					end
				elsif @arrow_direction >= 0.5
					if Gosu::button_down? Gosu::KbDown
						@game_over = 1
					end
				end
			end
		end
	end

	def draw_backgrounds	
		if @direction == 0
			moving_down
			if @temp == 0
				@obstacle = Obstacle.new(0, 165, -150, 0, @player, @obstacle_speed, @game_over)
				@temp = 1
			end
			@obstacle.draw
		elsif @direction == 1
			moving_right
			if @temp == 0
				@obstacle = Obstacle.new(1, 600, 240, 1, @player, @obstacle_speed, @game_over)
				@temp = 1
			end
			@obstacle.draw
		elsif @direction == 2
			moving_up
			if @temp == 0
				@obstacle = Obstacle.new(2, 165, 600, 2, @player, @obstacle_speed, @game_over)
				@temp = 1
			end
			@obstacle.draw
		elsif @direction == 3
			moving_left
			if @temp == 0
				@obstacle = Obstacle.new(3, -100, 240, 3, @player, @obstacle_speed, @game_over)
				@temp = 1
			end
			@obstacle.draw
		end
		collision
		@temp2 = 1
	end

	def collision
		@player.colliding?(@obstacle)
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
		@bg_y += @bg_move_speed
		@up_bg_y += @bg_move_speed
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
		@bg_x -= @bg_move_speed
		@right_bg_x -= @bg_move_speed
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
		@bg_y -= @bg_move_speed
		@up_bg_y -= @bg_move_speed
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
		@bg_x += @bg_move_speed
		@right_bg_x += @bg_move_speed
	end

end

window = Window.new
window.show