class Coordinate < Hash
  # This class allows to read and write the (x, y) coordinates as a Hash. Ex:
  # irb> position = Coordinate.new(0, 2)
  # => {x: 0, y: 2}
  # irb> position.x
  # => 0
  # irb> position.y = 3
  # => 3
  # irb> position
  # => {x: 0, y: 3}

  attr_accessor :x, :y

  def initialize(x, y)
    self[:x] = x
    self[:y] = y
  end

  def x
    self[:x]
  end

  def x=(value)
    self[:x] = value
  end

  def y
    self[:y]
  end

  def y=(value)
    self[:y] = value
  end

end
