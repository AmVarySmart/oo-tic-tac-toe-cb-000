class TicTacToe
  def initialize(board = Array.new(9, " "))
    @board = board
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
  ]

  def display_board

    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = input.to_i - 1
  end

  def turn
    puts "Enter a number 1-9: "
    input = gets.strip
    index = input_to_index(input)

    player = current_player

    if valid_move?(index)
      move(index,player)
      display_board
    else
      while !valid_move?(index)
        puts "Enter a number 1-9: "
        input = gets.strip
        index = input_to_index(input)
      end
    end
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

  def move(index, character = "X")
    @board[index] = character
    @board
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O" ? true : false
  end

   def valid_move?(index)
     !position_taken?(index) && index.between?(0,8) ? true : false
   end

   def turn_count
     @board.count{|space| space != " " && space != "" && space != nil}
   end

   def current_player
     turn_count.even? ? "X" : "O"
   end

   def won?
     WIN_COMBINATIONS.each do |combination|
       win_index_1 = combination[0]
       win_index_2 = combination[1]
       win_index_3 = combination[2]

       if position_taken?(win_index_1) && position_taken?(win_index_2) && position_taken?(win_index_3)
         if @board[win_index_1] == @board[win_index_2] && @board[win_index_2] == @board[win_index_3]
           return combination
         end
       end
     end
     false
   end

   def draw?
     full? && !won?
   end

   def full?
     @board.each do |space|
       if space == " " || space == "" || space == nil
         return false
       end
     end
     true
   end

   def over?
     won? || draw? ? true : false
   end

   def winner
     if won? != false
       winning_set = won?
       if @board[winning_set[0]] == "X"
         return "X"
       elsif @board[winning_set[0]] == "O"
         return "O"
       end
     end
     nil
   end
end
