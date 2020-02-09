require 'colorize'
require_relative 'chess_piece.rb'
require_relative 'chess_board.rb'

class Game
    attr_accessor :board_array, :win, :player
    def initialize
        @board = Board.new
        @win = false
        @player = "black"
        #welcome
        play
    end
    def play
        
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
        input_coords = @board.getMove(player)
        
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
            travel = @board.getTravel(@move, @piece)
            puts "travel: #{travel}"
            puts "piece loc #{@piece.location}"
            if @board.checkMove(travel, @piece)
                to_move = true
                path = @board.buildPath(piece_coords, @move, travel)
                #@piece.location = piece_coords                    #I dont know why the location is being changed, but a reset is needed here
                puts "Path: #{path}"
                if path.nil?
                    puts "Invalid move, go again"
                    takeTurn(@player)
                else
                    to_move = @board.checkPath(path, piece_coords)
                end
                if to_move == true
                    puts "PLACE!"
                    @board.placePiece(@piece, @move)
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
    def welcome
       
        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        puts "                  [/][/][/][/][/][/][/][/][/][/][/][/]"
        sleep(0.08)
        puts "                  |/|           Welcome            |/|"
        sleep(0.08)
        puts "                  |/|              to              |/|"
        sleep(0.08)
        puts "                  |/|                              |/|"
        sleep(0.08)
        puts "                  |/|     Command line Chess,      |/|"
        sleep(0.08)
        puts "                  |/|                              |/|"
        sleep(0.08)
        puts "                  |/|   a project from 'The Odin   |/|"
        sleep(0.08)
        puts "                  |/|       Project' curriculum    |/|"
        sleep(0.08)
        puts "                  |/|                              |/|"
        sleep(0.08)
        puts "                  |/|   Written by Dylan Maloney   |/|"
        sleep(0.08)
        puts "                  |/|         Feb. 2020            |/|"
        sleep(0.08)
        puts "                  |/|                              |/|"
        sleep(0.08)
        puts "                  [/][/][/][/][/][/][/][/][/][/][/][/]"
        sleep(0.08)
        5.times do
            puts "\n"
            sleep(0.08)
        end
        sleep(4)
        35.times do
            puts "\n"
            sleep(0.08)
        end
        puts "                  [/][/][/][/][/][/][/][/][/][/][/][/]"
        sleep(0.08)
        puts "                  |/|            Rules:            |/|"
        sleep(0.08)
        puts "                  |/|                              |/|"
        sleep(0.08)
        puts "                  |/|    To move a piece, enter    |/|"
        sleep(0.08)
        puts "                  |/|   the location of the piece  |/|"
        sleep(0.08)
        puts "                  |/|   to move, then 'to', then   |/|"
        sleep(0.08)
        puts "                  |/|   the location to move it to |/|"
        sleep(0.08)
        puts "                  |/|                              |/|"
        sleep(0.08)
        puts "                  |/|        EX:   a7 to a5        |/|"
        sleep(0.08)
        puts "                  |/|      will move black pawn    |/|"
        sleep(0.08)
        puts "                  |/|          two forward         |/|"
        sleep(0.08)
        puts "                  |/|                              |/|"
        sleep(0.08)
        puts "                  [/][/][/][/][/][/][/][/][/][/][/][/]"
        sleep(0.08)
        5.times do
            puts "\n"
            sleep(0.08)
        end     
        sleep(4)
        30.times do
            puts "\n"
            sleep(0.08)
        end    
    end
end





game = Game.new
   
