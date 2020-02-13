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
    def getInput(player)
        check = false
        until check == true do
            input_coords = @board.getMove(player)
            if input_coords == 0
                @board.displayError(1)
            elsif input_coords.length==2
                piece_coords = @board.convertCoords(input_coords[0])
                move_coords = @board.convertCoords(input_coords[1])
                piece = @board.board_array[piece_coords[0]][piece_coords[1]]   
                move = move_coords  
                if piece.is_a?(Piece)
                    if piece.color == player
                        check = true
                    else 
                        @board.displayError(3)
                    end
                else
                    @board.displayError(1)
                end 
            else
                @board.displayError(1)
            end       
        end 
        return piece, move, piece_coords, move_coords
    end

    def takeTurn(player, valid=true)
        puts "Start take trun"
        @board.refresh
        input = getInput(player)
        @piece = input[0]
        @move = input[1]
        piece_coords = input[2]
        move_coords = input[3]

        puts "piece: #{@piece}, move #{@move}"
        puts "piece_coords #{piece_coords}, move_coords #{move_coords}"
        puts "piece attack before turn #{@piece.attacking}"
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
                @piece = promo
                @board.placePiece(@piece, @move)    
            when "attack promotion"
                @piece = @board.promotion(@piece, @move)
                @board.pawnAttack(@piece, @move)
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
                puts "valid HERE"
                to_move = true
                path = @board.buildPath(piece_coords, @move, travel)
                type = @piece.type
                color = @piece.color
                to_move = @board.checkPath(path, piece_coords, type, color)  
                puts "to move: #{to_move}"
                case to_move
                    when 0
                        puts "placepiece"               #place          
                        @board.placePiece(@piece, @move)
                        @piece.move_counter += 1 
                    when -1              #error
                        @board.displayError(1)
                        takeTurn(@player)
                    when 1      
                        attack = 1
                        @board.placePiece(@piece, @move, attack)
                        @piece.move_counter += 1            
                end
                puts "valid here? should be done #{to_move}"
            when "invalid"
                @board.displayError(1)
                takeTurn(@player)
        end
        @board.setAllAttacking
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
   
