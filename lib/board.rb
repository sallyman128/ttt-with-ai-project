class Board
  attr_accessor :cells

  # starts a board class with an empty array of 9 elements
  def initialize 
    @cells = [
      " ", " ", " ",
      " ", " ", " ",
      " ", " ", " "
    ]
  end

  # resets the board to all empty elements
  def reset!
    @cells = [
      " ", " ", " ",
      " ", " ", " ",
      " ", " ", " "
    ]
  end 

  # prints the board
  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  # returns the value at the input location
  def position(input)
    @cells[input.to_i - 1]
  end

  # check if the board is full of non-empty spaces
  def full?
    full = true
    full = false if @cells.include?(" ")
    full
  end

  # computes the turn count by counting the number of non-empty cells
  def turn_count
    count = 0
    @cells.each do |cell|
      count += 1 if cell != " "
    end
    count
  end

  # returns true if a user's inputted position is already taken. returns false otherwise.
  def taken?(input)
    taken = true
    position = self.position(input)
    taken = false if position == " "
    taken
  end

  # checks if input is a valid number between 1 and 9
  # if input is valid, check if input is taken
  def valid_move?(input)
    valid = true
    if input.to_i >= 1 && input.to_i <= 9
      valid = false if self.taken?(input)
    else
      valid = false
    end
    valid
  end

  # sends the player token to the user's input location if it is valid
  def update(input, player)
    @cells[input.to_i - 1] = player.token if self.valid_move?(input)
  end
end