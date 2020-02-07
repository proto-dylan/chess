require 'colorize'
require './chess_piece.rb'
require './chess_board.rb'

class Game
    attr_accessor :board_array, :win, :player
    def initialize
        @board = Board.new
        @win = false
        @player = "black"
        
        play
    end
    def play
        #welcome
        @win = false
        until @win do     
            @board.takeTurn(@player) 
            if @player == 'black' && @win != true
                puts "switch to white"
                @player = 'white' 

            elsif @player == 'white' && @win != true
        
                puts "switch to black"
                @player = 'black'
            end
        end
    end
end



game = Game.new
   
