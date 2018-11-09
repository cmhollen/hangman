require './hangman.rb'
require './player.rb'

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
      @hangman.display_miss if @hangman.misses.length
      loop do 
        @player.options
        play_or_save
        @hangman.is_letter_included?(@player.letter)
        @hangman.display_correct
        @hangman.display_miss
        break if @hangman.game_over?
      end
    end

    def play_or_save
        if @player.option == 1
            @player.guess_letter
        elsif @player.option == 2
            save
            @player.guess_letter
        end
    end

    def new_game_or_saved_game
        puts "Enter 1 for new game or 2 for a saved game"
        @new_or_saved = gets.chomp.to_i
        if @new_or_saved == 1
            play
        elsif @new_or_saved == 2
            load
        end
    end

    def save
        Dir.mkdir("save") unless Dir.exists? "save"
        puts "Enter the name of the game to save"
        file_name = "save/#{gets.chomp}"
        File.open(file_name, "w") { |file| file.write(Marshal::dump(self))}
        puts "Game saved"
    end

    def load
        puts "Enter the name of the game you want to start"
        file_name = "save/#{gets.chomp}"
        file_name = File.read(file_name)
        game = Marshal::load(file_name)
        game.play
    end
end

game = Game.new(dictionary)
game.new_game_or_saved_game