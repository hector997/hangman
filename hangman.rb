puts "//////////////////////init//////////////////////////////"

class Hangman

  def initialize
    @word_to_guess = select_word
    @display_content = "_" * @word_to_guess.length
    @fails = 0
  end

  def menu
    puts "whelcome to the hangman game!"
    puts "<<<<<<<<< lets go! >>>>>>>>>>"
    puts "to exit the game, type 'quit' "
    start_game
  end

  def select_word
    words = File.readlines("words.txt").select { |word| word.length.between?(5, 12) }
    words[rand(words.length)].strip.to_s()

  end

  def start_game
    player_won = false

    while @fails != 10
      puts @display_content
      puts "#{10 - @fails.to_i} attemps left"
      puts "enter a letter or risk it with an entire word!"
      letters = gets.chomp
      break if letters == "quit"
      update_display(letters) if letters
      player_won = player_won?
      break if player_won
    end
    puts "game over, the secret word was: #{@word_to_guess}"
  end

  def update_display(letters)
    letters.downcase!

    current_state = "#{@display_content}"
    if letters.length == 1
      @display_content.length.times do |index|
        @display_content[index] = letters if @word_to_guess[index] == letters
      end
    elsif letters.length > 1 && letters == @word_to_guess
      player_won
    elsif letters.length > 1 && letters != @word_to_guess
      @fails = 10
      player_loose
    else
      @display_content = letters if letters == @word_to_guess.downcase

    end

    current_state == @display_content ? output(1) : output(0)
  end

  def player_loose
    if @fails < 10
      puts "game over!, the secret word was: #{@word_to_guess}"
    end
  end

  def player_won?
    unless @display_content.include?("_")
      puts "you found the correct word!!!!"
      true
    end
  end


  def output(increment)
   if @fails.to_i < 10
    @fails += increment
    case @fails
    when 0
      puts "  ______"
      puts "        |"
      puts "        |"
      puts "        |"
      puts "        |"
    when 1
      puts "  ______"
      puts "        |"
      puts "        |"
      puts "        |"
      puts "       /|"
    when 2
      puts "  ______"
      puts " |      |"
      puts "        |"
      puts "        |"
      puts "       /|"
    when 3
      puts "  ______"
      puts " |      |"
      puts "(..)    |"
      puts "        |"
      puts "       /|"
    when 4
      puts "  ______"
      puts " |      |"
      puts "(..)    |"
      puts " |      |"
      puts "       /|"
    when 5
      puts "  ______"
      puts " |      |"
      puts "(..)    |"
      puts "/|      |"
      puts "       /|"
    when 6
      puts "  ______"
      puts " |      |"
      puts "(..)    |"
      puts "/|\\     |"
      puts "       /|"
    when 7
      puts "  ______"
      puts " |      |"
      puts "(..)    |"
      puts "/|\\     |"
      puts "/      /|"
    when 8
      puts "  ______"
      puts " |      |"
      puts "(..)    |"
      puts "/|\\     |"
      puts "/ \\    /|"
    when 9
      puts "  ______"
      puts " |      |"
      puts "(.x)    |"
      puts "/|\\     |"
      puts "/ \\    /|"
    when 10
      puts "  ______"
      puts " |      |"
      puts "(xx)    |"
      puts '/|\\     |'
      puts "/ \\    /|"
    end
    puts ""
   end
 else
  puts ""
 end
end


new_game = Hangman.new
new_game.menu
