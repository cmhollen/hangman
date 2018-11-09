
class Player
    attr_accessor :letter, :option
  
      def initialize(name)
          @name = name
      end
  
      def options
          puts "Enter 1 to play or enter 2 to save the game"
          @option = gets.chomp.to_i
      end
  
      def guess_letter
          puts "Enter your guess:"
          @letter = gets.chomp.upcase
      end
  end