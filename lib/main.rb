class Square
  attr_reader :coords, :parent

  def initialize(coords, parent = nil)
    @coords = coords
    @parent = parent
  end

  def find_next_squares
    current_x, current_y = @coords
    possible_moves = [
    [current_x + 2, current_y + 1],
    [current_x + 2, current_y - 1],
    [current_x - 2, current_y + 1],
    [current_x - 2, current_y - 1],
    [current_x + 1, current_y + 2],
    [current_x + 1, current_y - 2],
    [current_x - 1, current_y + 2],
    [current_x - 1, current_y - 2]
  ]

    possible_moves.select { |coords| coords.all? { |coord| coord.between?(0, 7) } }
  end
end

def knight_moves(starting_square, destination_square)
  current_squares = []
  next_squares = [Square.new(starting_square)]

  until next_squares.any? { |square| square.coords == destination_square }
    current_squares = next_squares
    next_squares = []

    current_squares.each { |square| square.find_next_squares.each { |next_square| next_squares << Square.new(next_square, square) } }
  end

  destinations = next_squares.select { |square| square.coords == destination_square }

  paths = reconstruct_path(destinations)

  pretty_print(paths)
end

def reconstruct_path(destinations)
  paths = []

  destinations.each do |current|
    path = []

    while current
      path.unshift(current.coords)
      current = current.parent
    end
    paths << path
  end

  paths
end

def pretty_print(paths)
  puts "There are #{paths.size} possible paths which take #{paths.first.size - 1} moves."

  paths.each_with_index do |path, index|
    puts "\nPath #{index + 1}:"
    path.each { |coords| puts coords.inspect }
  end
end

knight_moves([0,0],[7,7])