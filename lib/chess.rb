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
            takeTurn(@player) 
            if @player == 'black' && @win != true
                puts "switch to white"
                @player = 'white' 

            elsif @player == 'white' && @win != true
        
                puts "switch to black"
                @player = 'black'
            end
        end
    end

    def takeTurn(player, valid=true)
        @board.refresh
        @piece = []
        @move = []
        if valid == false
            puts "Invalid @move"
        end
        input_coords = @board.getMove
        
        piece_coords = @board.convertCoords(input_coords[0])
        move_coords = @board.convertCoords(input_coords[1])

        puts "piece_coords #{piece_coords}"
        puts "move coords: #{move_coords}"
        puts "@board.board_array: #{@board.board_array[piece_coords[0]][piece_coords[1]].type}"

        @piece = @board.board_array[piece_coords[0]][piece_coords[1]] 
        puts "piece #{@piece}, #{@piece.location}"    
        @move = move_coords
        puts "piece:  #{@piece.type},   move: #{@move}"
            
        if @piece.is_a?(Piece)
            if @piece.color != @player
                puts "Wrong color, #{@player} turn"
                takeTurn(@player)
            end
            puts "outside check: move = #{@move} location = #{@piece.location}"
            if @board.checkMove(@move,@piece)
                to_move = true
                #path = @board.buildPathTree
                puts "path: #{path}"
                path.each do |path_move|
                    puts "check path #{path_move}"
                    if path_move != piece_coords
                        temp_row = path_move[0]
                        temp_col = path_move[1]
                        if @board.board_array[path_move[0]][path_move[1]] != 0
                            to_move = false
                        end
                    end
                end
                if to_move == true
                    puts "PLACE!"
                    @board.placePiece
                else
                    valid = false
                    takeTurn(@player, valid)
                end
            else
                valid = false
                takeTurn(@player, valid)
            end
        else
            puts "No piece, choose again"
            takeTurn(@player)
        end
    end

end



game = Game.new
   
