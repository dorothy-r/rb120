=begin
TODO:
3. Computer AI: Defense
4. Computer AI: Offense
5. Make computer play offensive move first
6. Have computer pick #5 if it's available
7. Have the user choose whether computer or human should go first
8. Add an option that lets the computer choose who goes first
9. Allow the player to pick any marker
10. Set a name for the player and computer

Optional:
- Have 2nd player be either computer or human
- Set difficulty level of computer opponent
- Minimax algorithm for unbeatable computer
- Option to play a bigger board (5x5 or 9x9)
- With a bigger board, add more than 2 players
=end

require "pry"
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    markers.size == 3 && markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_accessor :score, :name, :marker

  def initialize
    @marker = ''
    @score = 0
  end

  def to_s
    name
  end
end

class Human < Player
  def initialize
    super
    ask_name
  end

  def ask_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end
end

class Computer < Player
  def place_marker
    if board.unmarked_keys.include?(5)
      board[5] = marker
    end
  end
end

class Breezy < Computer
  def initialize
    super
    @name = 'Breezy'
  end
end

class Dee < Computer
  def initialize
    super
    @name = 'Dee'
  end

  # def place_marker
  #   if board.at_risk_lines
  #     # to do
  #   else
  #     super
  #   end
  # end
end

class Otto < Computer
  def initialize
    super
    @name = 'Otto'
  end

  def place_marker
    # to do
  end
end

class Minnie < Computer
  def initialize
    super
    @name = 'Minnie'
  end
end

class TTTGame
  MARKERS = ['X', 'O']
  # FIRST_TO_MOVE = @player1.marker

  attr_reader :board, :player1
  attr_accessor :winning_score, :player2, :current_player

  def initialize
    @board = Board.new
    @player1 = Human.new
    @player2 = nil
    @current_player = nil
    @winning_score = 0
  end

  def play
    clear
    display_welcome_message
    game_setup
    main_game
    display_goodbye_message
  end

  private

  def game_setup
    player_setup # to do
    set_winning_score
    set_markers
    select_first_player
    binding.pry
  end

  def player_setup
    choice = ''
    puts 'Would you like to play against another player or a computer opponent?'
    puts 'Enter "1" for a two-player game, and "2" to challenge the computer.'
    loop do
      choice = gets.chomp
      break if %w(1 2).include?(choice)
      puts 'Please enter "1" or "2".'
    end

    self.player2 = choice == '1' ? Human.new : ask_difficulty_level
  end

  def ask_difficulty_level
    choice = ''
    puts 'Please choose a difficulty setting for the computer:'
    puts '1: Easy'
    puts '2: Medium'
    puts '3: Difficult'
    puts '4: Impossible'
    loop do
      choice = gets.chomp
      break if %(1 2 3 4).include?(choice)
      puts 'Please enter a number between 1 and 4.'
    end
    case choice
    when '1' then Breezy.new
    when '2' then Dee.new
    when '3' then Otto.new
    when '4' then Minnie.new
    end
  end

  def set_markers
    choice = ''
    puts "#{player1}, which marker would you like? #{MARKERS.join(' or ')}?"
    loop do
      choice = gets.chomp
      break if MARKERS.include?(choice)
      puts "Please choose #{MARKERS.join(' or ')}"
    end
    player1.marker = choice
    player2.marker = MARKERS.reject { |m| m == choice }.first
  end

  def select_first_player
    puts "Who should go first?"
    puts "Press '1' for #{player1.name}"
    puts "Press '2' for #{player2.name}"
    choice = gets.chomp
    self.current_player = choice == '1' ? player1 : player2
  end

  def main_game
    loop do
      play_round
      display_grand_winner
      break unless play_again?

      reset_scores
      display_play_again_message
    end
  end

  def play_round
    loop do
      display_board
      player_move
      display_result
      update_score if board.winning_marker
      display_score
      reset
      break if grand_winner

      display_next_round_message
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?

      clear_screen_and_display_board if human_turn?
    end
  end

  def grand_winner
    if computer.score == winning_score
      computer
    elsif human.score == winning_score
      human
    else
      nil
    end
  end

  def display_grand_winner
    puts "#{grand_winner} is the grand winner! Congratulations!"
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def set_winning_score
    puts "What would you like to play to? Enter a number between 1 and 10: "
    score = gets.chomp
    loop do
      break if score.to_i > 0 && score.to_i < 11
      puts "That won't work! Please choose a winning score between 1 and 10:"
      score = gets.chomp
    end
    self.winning_score = score.to_i
  end

  def display_score
    puts "Current Score"
    puts "Human: #{human.score}"
    puts "Computer: #{computer.score}"
  end

  def display_next_round_message
    puts 'Time for another round!'
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def display_board
    puts "#{player1}, you're #{player1.marker}. #{player2} is #{player2.marker}."
    puts ''
    board.draw
    puts ''
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor(arr, punct = ', ', word = 'or')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{word} ")
    else
      arr[0, arr.size - 1].join(punct) + "#{punct}#{word} #{arr[-1]}"
    end
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)

      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def current_player_moves
    human_turn? ? human_moves : computer_moves
    switch_players
  end

  def human_turn?
    @current_player.class == Human
  end

  def switch_players
    current_player = current_player == player1 ? player2 : player1
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts 'You won!'
    when computer.marker
      puts 'Computer won!'
    else
      puts "It's a tie!"
    end
  end

  def update_score
    board.winning_marker == human.marker ? human.score += 1 : computer.score += 1
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer

      puts 'Sorry, must be y or n'
    end

    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end

game = TTTGame.new
game.play
