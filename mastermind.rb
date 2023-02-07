class Mastermind

  attr_accessor :round
  attr_reader :code

  def initialize
    @round = 1
    @code = nil
  end

  def rules
    puts <<-TEXT
      \n
      In this game you have 12 turns to guess a 4 digit code.
      The numbers will range from 1 to 6 and can appear more than once.
      After every guess you will be given clues. The clues will tell you
      how many numbers you guessed correctly and if they were in the correct
      position. 
      You win when you guess the combination before your geusses run out.
      Good luck.\n\n
    TEXT
  end

  # create a simple option of 1 or 2 to start a game.
  def choose_player
    puts "\nDo you want to be the Code Maker or the Code Breaker."
    print "Choose 1 for Code Maker or 2 for Code Breaker: "
    input = gets.chomp.to_i
    if (input == 1)
      puts <<-TEXT
      \n
      You task is to create a 4 digit code containing numbers ranging
      from 1 to 6. The Computer will have 12 attempts to break your code.\n\n
      TEXT
      print "Please enter your 4 digit code: "
      @code = valid_numbers(gets.chomp).to_i
      computer_player
    elsif (input == 2)
      human_player
    else
      choose_player
    end
  end

  def human_player
    rules
    code = computer_code
    # create a basic loop to check if you have either won or lost the game.
    loop do
      if round > 12
        puts "Game Over!"
        break
      elsif round == 12
        print "\nThis is your final guess. Choose wisely: "
        input = valid_numbers(gets.chomp).to_i
        if input == code
          puts "You win. The code was #{code}."
          break
        else
          check_guess(input, code)
        end
      else
        print "\nEnter your guess: "
        input = valid_numbers(gets.chomp).to_i
        if input == code
          puts "You win. The code was #{code}."
          break
        else
          check_guess(input, code)
        end
      end
      @round += 1
    end
  end

  def computer_player
    code = @code
    # create a basic loop to check if the computer's random guess is correct.
    loop do
      if round > 12
        puts "Game Over!"
        break
      else
        input = computer_code
        puts "\nThe Computer's guess is #{input}."
        if input == code
          puts "The Computer wins. The code was #{code}."
          break
        else
          check_guess(input, code)
        end
      end
      @round += 1
    end
  end

  def valid_numbers(input)
    # split the numbers to check they are in range.
    if (input.split("").any? { |num| num.to_i < 1 || num.to_i > 6 })
      print "Please choose numbers from 1 to 6: "
      input = valid_numbers(gets.chomp).to_i
      # check that only numbers are entered and that there are only 4.
    elsif (input.to_i != 0) && (input.to_s.length == 4)
      input
    else
      print "Please enter 4 valid numbers: "
      input = valid_numbers(gets.chomp).to_i
    end
  end

  def check_guess(input, code)
    input_split = input.to_s.split("") # split the guess into an array.
    code_split = code.to_s.split("") # split the code into an array.
    # merge both arrays and count how many are the same number in the same position.
    exact = code_split.zip(input_split).count { |a, b| a == b }
    inexact_position = 0
    code_copy = code_split.clone #create a copy of the code array.
    input_split.each do |digit| # loop through the input array.
      # if the code array includes any numbers from the input array,
      # delete that number from the code array and count how many times that happens.
      if code_copy.include?(digit)
        code_copy.delete_at(code_copy.find_index(digit))
        inexact_position += 1
      end
    end
    inexact = inexact_position - exact
    puts "How many you got exactly right: #{exact}"
    puts "How many you got not quite right: #{inexact}"
  end
  
  def computer_code # the computer's random code guess.
    [rand(1..6), rand(1..6), rand(1..6), rand(1..6)].join.to_i
  end

end

play = Mastermind.new
play.choose_player