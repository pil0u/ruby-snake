# Documentation officielle : https://github.com/gosu/gosu/wiki/ruby-tutorial

require 'gosu'
require_relative '../config'
require_relative 'snake'
require_relative 'food'

class Game < Gosu::Window
	
	TILE_SIZE = Config::TILE_SIZE
	WINDOW_SIZE = Config::WINDOW_SIZE
	START_SPEED = Config::START_SPEED

	# Méthode "constructeur"
	def initialize
		super WINDOW_SIZE, WINDOW_SIZE
		self.caption = "Snakiscount"

		# @background_image = Gosu::Image.new('./media/background.jpg', tileable: true)
		@snake = Snake.new
		# @food = Food.new
		@food = Food.popup

		@speed = START_SPEED
		@last_move = Time.now
	end

	# Méthode pour mettre à jour la logique du jeu
	# Elle est appelée 60 fois par seconde
	def update
		return if (Time.now - @last_move) < @speed
		
		update_direction
		@snake.move
		@last_move = Time.now

		if @snake.dead?
			sleep(2)
			reset_game
		end

		if @food.eaten_by?(@snake)
			@snake.expand
			@food = Food.popup
		end

		p @snake
		p @food

		# 	for j in (0..TILE_SIZE)
		# 		Gosu.draw_rect(i*TILE_SIZE, j*TILE_SIZE, TILE_SIZE, TILE_SIZE,
		# 			(i+j) % 2 == 0 ? Gosu::Color::WHITE : Gosu::Color::BLACK
		# 			# [
		# 			# 	Gosu::Color::RED,
		# 			# 	Gosu::Color::YELLOW,
		# 			# 	Gosu::Color::BLUE,
		# 			# 	Gosu::Color::GREEN,
		# 			# 	Gosu::Color::WHITE,
		# 			# 	Gosu::Color::GRAY,
		# 			# 	Gosu::Color::BLACK,
		# 			# 	Gosu::Color::AQUA,
		# 			# 	Gosu::Color::FUCHSIA,
		# 			# 	Gosu::Color::CYAN,
		# 			# ].sample
		# 			)
		# 		# puts "#{i} / #{j}"
		# 	end
		# end
		# raise
	end

	# Méthode pour mettre à jour l'affichage, le rendu du jeu
	# Elle est _normalement_ appelée 60 fois par seconde
	def draw
		# @background_image.draw(0, 0, 0)
		@snake.draw
		@food.draw
	end

	private

	def reset_game
		@speed = START_SPEED
		@snake = Snake.new
		@food = Food.popup
	end

	def button_up(id)
		id == Gosu::KB_ESCAPE ? close : super
	end

	def update_direction
		if (Gosu.button_down?(Gosu::KB_RIGHT) && @snake.direction != "left")
			@snake.direction = "right"
		elsif (Gosu.button_down?(Gosu::KB_DOWN) && @snake.direction != "up")
			@snake.direction = "down"
		elsif (Gosu.button_down?(Gosu::KB_LEFT) && @snake.direction != "right")
			@snake.direction = "left"
		elsif (Gosu.button_down?(Gosu::KB_UP) && @snake.direction != "down")
			@snake.direction = "up"
		end
	end

end
