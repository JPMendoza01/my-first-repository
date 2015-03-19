def initialize_board
  b = {}
  (1..9).each { |position| b[position] = ' '}
  b
end


def draw_board(b)
  system 'clear'
  puts " #{b[1]} | #{b[2]} | #{b[3]} "
  puts "-----------"
  puts " #{b[4]} | #{b[5]} | #{b[6]} "
  puts "-----------"
  puts " #{b[7]} | #{b[8]} | #{b[9]} "
end

def empty_positions(board)
  board.select { |k , v| v == ' '}.keys
end

def two_in_a_row(hsh, mrkr)
  if hsh.values.count(mrkr) == 2
    hsh.select{|k,v| v == ' '}.keys.first
  else
    false
  end
end

def player_picks_square(board)
  puts "Pick a square (1 - 9):"
  position = gets.chomp.to_i
  board[position] = 'X'
end

def computer_picks_square(board)
  position = empty_positions(board).sample
  board[position] = 'O'
end

def check_winner(board)
 winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    return "player" if board.values_at(*line).count('X') ==3
    return "computer" if board.values_at(*line).count('O') == 3
  end
  nil
end

def nine_positions_are_filled?(board)
  empty_positions(board) == []
end

def announce_winner(winner)
  puts "#{winner} won!"
end

board = initialize_board
  draw_board(board)

begin
  player_picks_square(board)
  draw_board(board)
  computer_picks_square(board)
  draw_board(board)
  winner = check_winner(board)
end until winner || empty_positions(board).empty?

if winner
  announce_winner(winner)
else
  puts "its a tie!"
  
end
  