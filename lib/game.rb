# Documentation officielle : https://github.com/gosu/gosu/wiki/ruby-tutorial

require 'gosu'
require_relative '../config'
require_relative 'snake'
require_relative 'food'

class Game < Gosu::Window
  TILE_SIZE = Config::TILE_SIZE
  WINDOW_SIZE = Config::WINDOW_SIZE
  INITIAL_SPEED_LEVEL = Config::INITIAL_SPEED_LEVEL
  SPEED_ACCELERATION_RATE = Config::SPEED_ACCELERATION_RATE
  HIGH_SCORE_PATH = Config::HIGH_SCORE_PATH

  # Méthode "constructeur"
  def initialize
    super WINDOW_SIZE, WINDOW_SIZE
    self.caption = "Snake game by pil0u"
    @background_image = Gosu::Image.new('./media/background.jpg', tileable: true)
    @font = Gosu::Font.new(24)

    @snake = Snake.new
    @food = Food.popup

    @speed_level = INITIAL_SPEED_LEVEL
    update_refresh_rate
    @time_last_move = Time.now

    @score = 0
    initialize_highscore
  end

  # Méthode pour mettre à jour la logique du jeu
  # Elle est appelée 60 fois par seconde
  def update
    return if (Time.now - @time_last_move) < @refresh_rate

    update_direction
    @snake.move
    @time_last_move = Time.now

    if @snake.dead?
      @snake.play_dead_sound
      sleep(3)

      if @score > @highscore
        @highscore = @score
        update_highscore(@highscore)
      end

      reset_game
    end

    if @food.eaten_by?(@snake)
      @food.play_sound
      @food = Food.popup

      @snake.expand
      accelerate

      @score += 1
    end
  end

  # Méthode pour mettre à jour l'affichage, le rendu du jeu (pas de logique)
  # Elle est _au mieux_ appelée 60 fois par seconde
  def draw
    @background_image.draw(0, 0, 0)

    @snake.draw
    @food.draw

    @font.draw_text("Score: #{@score} / High score: #{@highscore}", 10, 10, 0, 1, 1, color=Gosu::Color::YELLOW)
  end

  private

  def initialize_highscore
    if File.exist? HIGH_SCORE_PATH
      file = File.open(HIGH_SCORE_PATH)
      @highscore = file.readlines.last.split(' --- ').last.to_i
      file.close
    else
      @highscore = 0
      update_highscore(@highscore)
    end
  end

  def update_highscore(score)
    file = File.new(HIGH_SCORE_PATH, "a")
    file.puts("#{Time.now.strftime("%Y-%m-%d %H:%M:%S")} --- #{score}")
    file.close
  end

  def reset_game
    @speed_level = INITIAL_SPEED_LEVEL
    update_refresh_rate

    @snake = Snake.new
    @food = Food.popup

    @score = 0
  end

  def update_refresh_rate
    @refresh_rate = 1.0 / @speed_level
  end

  def accelerate
    @speed_level *= (1 + SPEED_ACCELERATION_RATE)
    update_refresh_rate
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
