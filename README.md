# ruby-snake
A modest Snake game using the Gosu framework

## Installation

Some dependencies are required for Gosu to run.

### Linux

This was tested on Pop_OS! 20.04:
``` zsh
sudo apt update
sudo apt install build-essential libsdl2-dev libsdl2-ttf-dev\
  libpango1.0-dev libgl1-mesa-dev libfreeimage-dev libopenal-dev\
  libsndfile-dev libmpg123-dev
gem install gosu
```

Please refer to [Gosu's Getting started instructions](https://github.com/gosu/gosu/wiki/Getting-Started-on-Linux) for more information.

### macOS (untested)

``` zsh
brew update
brew install sdl2
gem install gosu
```

## Run

Open the game folder in a terminal and type:
``` zsh
path/to/ruby-snake$ ruby run.rb
```

Move with the arrow keys of the keyboard.
You can close the window with the `Esc` key.

In the config.rb file, you can edit and configure some values:
- `TILE_SIZE` for a bigger window, just choose an even number between 16 and 28 (default: 20)
- `INITIAL_SPEED_LEVEL`, which corresponds to the initial speed of the snake (default: 10)
- `SPEED_ACCELERATION_RATE`, which is the rate at which the snake accelerates each time it eats some food (default: 0.03, which means +3% every time)
- `HIGH_SCORE_PATH` to specify a different path to store the high scores (default: "highscores.txt")
