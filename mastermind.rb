class Mastermind

  attr_accessor :round
  attr_reader :code

  def initialize
    @round = 1
    @code = nil
  end

  def rules
    puts <<-TEXT
      \nIn this game you have 12 turns to guess a 4 digit code.
      The numbers will range from 1 to 6 and can appear more than once.
      After every guess you will be given clues. The clues will consist
      of an X or an O. The X will mean that 1 number is correct and is in 
      the correct position, and the O will mean that 1 number is correct but
      not in the correct position.
      You win when you guess the combination before your geusses run out.
      Good luck.\n\n
    TEXT
  end

  def game
    rules
    code = computer_code
    loop do
      if round > 12
        puts "Game Over!"
        break
      elsif round == 12
        puts "This is your final guess. Choose wisely."
        input = gets.chomp.to_i
          if input == code
            puts "You win. The code was #{code}."
            break
          end
      else
        input = gets.chomp.to_i
        if input == code
          puts "You win. The code was #{code}."
          break
        end
      end
      @round += 1
    end
  end
  
  def computer_code
    [rand(1..6)].join.to_i
  end

end

play = Mastermind.new
play.game