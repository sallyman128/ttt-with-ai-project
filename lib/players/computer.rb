module Players
  class Computer < Player
    def move(board)
      input = 1
      until board.valid_move?(input) do
        input += 1
      end
      input.to_s
    end
  end
end