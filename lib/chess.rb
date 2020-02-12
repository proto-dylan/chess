require 'colorize'
require_relative 'chess_piece.rb'
require_relative 'chess_board.rb'

class Game
    attr_accessor :board_array, :win, :player
    def initialize
        @board = Board.new
        @win = false
        @player = "white"
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
        puts "input_coords: #{input_coords}"
        if input_coords == 0
            @board.displayError(1)
            takeTurn(@player)
        elsif input_coords.length==2
            puts "input coords #{input_coords}"
            piece_coords = @board.convertCoords(input_coords[0])
            move_coords = @board.convertCoords(input_coords[1])
            @piece = @board.board_array[piece_coords[0]][piece_coords[1]]   
            @move = move_coords  
            puts "piece? #{@piece}"  
            if @piece.is_a?(Piece)
                if @piece.color != @player
                    @board.displayError(3)
                    takeTurn(@player)
                end
                travel = @board.getTravel(@move, @piece)
                if @piece.type == 'knight'
                    check_move = "knight"
                else
                    check_move = @board.checkMove(travel, @piece)
                end
                case check_move
                when "attack"
                    @board.pawnAttack(@piece, @move)
                when "promotion"
                    promo = @board.promotion(@piece, @move)
                    @board.placePiece(@piece, @move)
                when "attack promotion"
                    promo = @board.promotion(@piece, @move)
                    @board.pawnAttack(@piece, @move, attack = 1)
                when "passant"
                    @board.passant(travel, @piece)
                when "knight"
                    check_knight = @board.knightCheck(@piece, @move, travel)
                    case check_knight 
                        when 1
                            attack = 1
                            @board.placePiece(@piece, @move, attack)
                            @piece.move_counter += 1 
                        when 0
                            @board.placePiece(@piece, @move)
                            @piece.move_counter += 1
                        when -1
                            @board.displayError(1)
                            takeTurn(@player)
                        when -2
                            @board.displayError(2)
                            takeTurn(@player)
                    end    
                when "valid"
                    to_move = true
                    path = @board.buildPath(piece_coords, @move, travel)
                    type = @piece.type
                    color = @piece.color
                    to_move = @board.checkPath(path, piece_coords, type, color)  
                    case to_move
                        when 0               #place          
                            @board.placePiece(@piece, @move)
                            @piece.move_counter += 1 
                            if @piece.type == 'pawn'
                                @piece.attacking = @board.getPawnAttacking(@piece.location, @piece.color)     #sets ATtacking for pawns new loc
                            end
                        when -1              #error
                            valid = false
                            @board.displayError(1)
                            takeTurn(@player, valid)
                        when 1       
                            puts "ATTACK! switch"                               #attack
                           attack = 1
                           @board.placePiece(@piece, @move, attack)
                           @piece.move_counter += 1               
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
   
