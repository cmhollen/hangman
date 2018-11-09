dictionary = File.read("dictionary.txt")
dictionary = dictionary.split

class Game 
    def initialize(dictionary)
      @player = Player.new("Player 1")
      @hangman = Hangman.new("Computer", dictionary)
    end

    def play 
      puts "#{@hangman.name} has chose a secret word. Can you guess it?"
      puts
      @hangman.display_correct
      loop do 
        @player.guess_letter
        @hangman.is_letter_included?(@player.letter)
        @hangman.display_correct
        @hangman.display_miss
        break if @hangman.game_over?
      end
    end
end

class Hangman
  attr_accessor :name

  def initialize(name, dictionary)
    @name = name
    @word = dictionary.select{ |w| w.length >= 5 && w.length <= 12 }.sample.upcase
    @blank_letters = Array.new(@word.length, " _ ")
    @misses = []
  end

  def display_correct
    p @blank_letters
    puts
  end

  def is_letter_included?(letter)
    if @word.include? letter
        included(letter)
    else
        not_included(letter)
    end
  end

  def included(letter)
    @word.split("").each_with_index do |w, idx|
        if w == letter
            @blank_letters[idx] = letter
        end
    end
    puts "Correct!"
    puts
  end

  def not_included(letter)
    @misses.push(letter)
    puts "Miss number #{@misses.length}"
    puts
  end

  def display_miss
    p "Misses:"
    p @misses
  end

  def game_over?
    if winner
        true
    elsif loser
        true
    else 
        false
    end
  end

  def winner
    puts "got to winner"
    if @blank_letters.join == @word
        puts "You guessed the word! You win!"
        true
    else
        false
    end
  end

  def loser
    puts "got to loser"
    if @misses.length == 6
        puts "HANGMAN! You lose!"
        true
    else
        false
    end
  end
end


class Player
  attr_accessor :letter

    def initialize(name)
        @name = name
    end

    def guess_letter
        puts "Enter your guess:"
        @letter = gets.chomp.upcase
    end
end

game = Game.new(dictionary)
game.play