class Square
  attr_reader :coords, :parent

  def initialize(coords, parent = nil)
    @coords = coords
    @parent = parent
  end

  def find_next_squares
    # Returns array of possible next squares
  end
end

def knight_moves(starting_square, destination_square)
  current_squares = []
  next_squares = [Square.new(starting_square)]

  until next_squares.any { |square| square.square == destination_square }
    current_squares = next_squares
    next_squares = []

    current_squares.each { |square| square.find_next_squares.each { |next_square| next_squares << Square.new(next_square, square) } }
  end
end