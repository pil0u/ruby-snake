require_relative '../config'
require_relative 'coordinate'

class Snake
	attr_reader :x, :y
	attr_accessor :direction

	TILE_SIZE = Config::TILE_SIZE
  WINDOW_SIZE = Config::WINDOW_SIZE

	def initialize
		@x = 0
		@y = TILE_SIZE
		@tail_tiles = []
		@tail_length = 0

		@direction = "right"
	end

  def dead?
    outside_window = (@x < 0 || @x >= WINDOW_SIZE || @y <0 || @y >= WINDOW_SIZE)
    return outside_window
  end

	def expand
		@tail_length += 1
	end

	def move
		@tail_tiles.unshift([@x, @y])
		@tail_tiles = @tail_tiles.first(@tail_length)

		case @direction
			when "right" then @x += TILE_SIZE
			when "down"  then @y += TILE_SIZE
			when "left"  then @x -= TILE_SIZE
			when "up"    then @y -= TILE_SIZE
		end
	end

	def draw
		Gosu.draw_rect(@x, @y, TILE_SIZE, TILE_SIZE, Gosu::Color::WHITE)
		@tail_tiles.each do |tail_tile|
			Gosu.draw_rect(tail_tile[0], tail_tile[1], TILE_SIZE, TILE_SIZE, Gosu::Color::WHITE)
		end
	end

end
