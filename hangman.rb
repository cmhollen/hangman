class Hangman
  attr_accessor :name, :misses

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
    puts "Misses:"
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
    if @blank_letters.join == @word
        puts "You guessed the word! You win!"
        true
    else
        false
    end
  end

  def loser
    if @misses.length == 6
        puts "HANGMAN! You lose!"
        puts "The secret word was #{@word}"
        true
    else
        false
    end
  end
end



