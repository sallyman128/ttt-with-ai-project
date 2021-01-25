class Game
  attr_accessor :player_1, :player_2, :board

  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8],  # by row
    [0,3,6], [1,4,7], [2,5,8],  # by column
    [0,4,8], [2,4,6]            # by diagonal
  ]

  # initialize Game default with two Human players and a new Board
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board    
  end

  # use board.turn_count to identify the current player
  def current_player
    current = @player_1
    current = @player_2 if @board.turn_count.odd?
    current
  end

  def won?
    # initially set result to be false
    winning_positions = false

    # collect the indexes of each player's token
    p1_positions = []
    p2_positions = []
    @board.cells.each_with_index do |cell, index|
      p1_positions << index if cell == "X"
      p2_positions << index if cell == "O"
    end

    # check if any combination of 3 in either p1 or p2 position sets includes a win condition
    WIN_COMBINATIONS.each do |win_combo|
      winning_positions = win_combo if p1_positions.combination(3).include?(win_combo)
      winning_positions = win_combo if p2_positions.combination(3).include?(win_combo)
    end

    # either return false or the winning positions
    winning_positions
  end

  # draw is true if the board is full and there is no winning condition met
  def draw?
    draw = false
    draw = true if @board.full? && self.won? == false
    draw
  end

  # game is over when the @board is full or winning condition met
  def over?
    over = false
    over = true if self.draw? || self.won?
    over
  end

  # check if a win condition has been met
  # collect the indexes of each player's tokens
  # return the token of the player who has met the winning condition
  def winner
    winner = nil
    if self.won?
      p1_positions = []
      p2_positions = []
      @board.cells.each_with_index do |cell, index|
        p1_positions << index if cell == "X"
        p2_positions << index if cell == "O"
      end

      WIN_COMBINATIONS.each do |win_combo|
        winner = @player_1.token if p1_positions.combination(3).include?(win_combo)
        winner = @player_2.token if p2_positions.combination(3).include?(win_combo)
      end
    end

    winner
  end

  def turn
    # requests input from player. if input is not valid, request input again. else input is valid, board.update
    puts "Please input a valid position."
    input = self.current_player.move(@board)

    until @board.valid_move?(input)
      puts "Please input a valid position."
      input = self.current_player.move(@board)
    end

    @board.update(input, self.current_player) 
  end

  def play
    until self.over? do
      self.turn
    end

    if self.won?
      puts "Congratulations #{self.winner}!"
    else
      puts "Cat's Game!"
    end
  end
end