=begin
TODO:
- Keep track of a history of moves
- Add personalities for different computer players
- Generally improve gameplay and UX
=end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  ABBREVS = ['r', 'p', 'sc', 'l', 'sp']

  attr_reader :value, :defeats, :verbs

  def >(other_move)
    defeats.include?(other_move.class)
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
    @defeats = [Scissors, Lizard]
    @verbs = ['crushes', 'crushes']
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @defeats = [Rock, Spock]
    @verbs = ['covers', 'disproves']
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @defeats = [Paper, Lizard]
    @verbs = ['cuts', 'decapitates']
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @defeats = [Spock, Paper]
    @verbs = ['poisons', 'eats']
  end
end

class Spock < Move
  def initialize
    @value = 'Spock'
    @defeats = [Scissors, Rock]
    @verbs = ['smashes', 'vaporizes']
  end
end

class Player
  attr_accessor :name, :score
  attr_reader :move

  def initialize
    set_name
    @score = 0
  end

  def move=(choice)
    @move = case choice
            when 'rock', 'r' then Rock.new
            when 'paper', 'p' then Paper.new
            when 'scissors', 'sc' then Scissors.new
            when 'lizard', 'l' then Lizard.new
            when 'spock', 'sp' then Spock.new
            end
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = ''
    loop do
      puts "Please choose (r)ock, (p)aper, (sc)issors, (l)izard, or (sp)ock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice) || Move::ABBREVS.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = choice
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move::VALUES.sample
  end
end

class RPSGame
  attr_accessor :human, :computer, :winning_score

  def initialize
    @human = Human.new
    @computer = Computer.new
    @winning_score = 0
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def set_winning_score
    puts "What would you like to play to? Enter a number between 1 and 10: "
    score = gets.chomp.to_i
    loop do
      break if score > 0 && score < 11
      "That won't work! Please choose a winning score between 1 and 10:"
    end
    self.winning_score = score
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif computer.move > human.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def update_score
    if human.move > computer.move
      human.score += 1
    elsif computer.move > human.move
      computer.score += 1
    end
  end

  def display_score
    puts "Current Score"
    puts "#{human.name}: #{human.score}"
    puts "#{computer.name}: #{computer.score}"
  end

  def display_grand_winner
    if human.score == winning_score
      puts "#{human.name}, you are the Grand Winner! Congratulations!"
    else
      puts "#{computer.name} is the Grand Winner! Better luck next time!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must enter y or n."
    end

    answer.downcase == 'y'
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def play_round
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      update_score
      display_score
      break if human.score == winning_score || computer.score == winning_score
    end
  end

  def play
    display_welcome_message
    set_winning_score

    loop do
      play_round
      display_grand_winner
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
