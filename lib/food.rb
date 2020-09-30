require_relative '../config'
require_relative 'coordinate'

class Food
	TILE_SIZE = Config::TILE_SIZE

	def initialize(x, y)
		# @x = TILE_SIZE
		# @y = 0
		@x = x
		@y = y
	end

	def self.popup
		x = rand(0...TILE_SIZE) * TILE_SIZE
		y = rand(0...TILE_SIZE) * TILE_SIZE

		Food.new(x, y)
	end

	def eaten_by?(snake)
		@x == snake.x && @y == snake.y
	end

	def draw
		Gosu.draw_rect(@x, @y, TILE_SIZE, TILE_SIZE, Gosu::Color::RED)
	end

end
