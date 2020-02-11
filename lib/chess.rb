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

        input_coords = @board.getMove(@player)
        if input_coords == 0
            @board.displayError(1)
            takeTurn(@player)
        end
        piece_coords = @board.convertCoords(input_coords[0])
        move_coords = @board.convertCoords(input_coords[1])

        @piece = @board.board_array[piece_coords[0]][piece_coords[1]]   
        @move = move_coords
            
        if @piece.is_a?(Piece)
            if @piece.color != @player
                @board.displayError(3)
                takeTurn(@player)
            end
            
            travel = @board.getTravel(@move, @piece)
            check_move = @board.checkMove(travel, @piece)

            if check_move == "attack"
                @board.placePiece(@piece, @move)
            elsif check_move == "valid"
                to_move = true
                path = @board.buildPath(piece_coords, @move, travel)
                
                #@piece.location = piece_coords                    #I dont know why the location is being changed, but a reset is needed here
                puts "Path: #{path}"
                if path.nil?
                    puts "Invalid move, go again"
                    takeTurn(@player)
                else
                    type = @piece.type
                    to_move = @board.checkPath(path, piece_coords, type)
                    puts "insinde TO MOVE #{to_move}"
                end
                puts "outsnsinde TO MOVE #{to_move}"
                case to_move
                    when 0               #place
                        puts "PLACE!"
                        @board.placePiece(@piece, @move)
                        puts "move_counter before: #{@piece.move_counter}"
                        @piece.move_counter += 1
                        puts "move_counter after: #{@piece.move_counter}"
                        if @piece.type == 'pawn'
                            @piece.attacking = @board.getPawnAttacking(@piece.location, @piece.color)     #sets ATtacking for pawns new loc
                            puts "piece.location: #{@piece.location}"
                        end
                    when -1              #error
                        valid = false
                        @board.displayError(1)
                        takeTurn(@player, valid)
                    when 1                #ATTACK!!    
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
   
