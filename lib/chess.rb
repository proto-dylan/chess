require 'colorize'
require_relative 'chess_piece.rb'
require_relative 'chess_board.rb'
require 'yaml'

class Game
    attr_accessor :board_array, :win, :player
    def initialize
        @board = Board.new
        @win = false
        @player = "white"
        #welcome
        @board.refresh
        play
    end
     
    def load_game
        loaded_game = File.read("SavedGames/save_game.yaml")
        game = YAML.load(loaded_game)
        @player = game[:player]
        @board = game[:board]
        @win = game[:win]
    end

    def save_game
        Dir.mkdir("SavedGames") unless Dir.exists?("SavedGames")
        filename = "SavedGames/save_game.yaml"
        hash = { :player => @player, :board => @board, :win => @win}  
        dump = YAML::dump(hash)
        File.open(filename, 'w') do |file|
            file.write(dump)
        end 
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
            if input_coords == "save"
                return "save"
            elsif input_coords == "load"
                return "load"
            elsif input_coords == "reset"
                return "reset"
            elsif input_coords == 0
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
        @board.setAllAttacking
        input = getInput(player)       
        if input == "load"
            load_game  
            player = @player
            @board.displayMessage(2)
            takeTurn(player)
        elsif input == "save"
            save_game
            @board.displayMessage(1)
            takeTurn(player)   
        elsif input == "reset"
            @board.displayMessage(3)
            game = Game.new
        else
            @piece = input[0]
            @move = input[1]
            piece_coords = input[2]
            move_coords = input[3]
            travel = @board.getTravel(@move, @piece)
            if @piece.type == 'knight'
                check_move = "knight"
            else
                check_move = @board.checkMove(travel, @piece)            #checks if move is within moves allowed
            end                     
            case check_move
                when "castle"
                    @board.placeCastle(@piece, @move)
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
                    to_move = true
                    path = @board.buildPath(piece_coords, @move, travel)
                    type = @piece.type
                    color = @piece.color
                    to_move = @board.checkPath(path, piece_coords, color) 
                    case to_move
                        when 0               #place          
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
                when "invalid"
                    @board.displayError(1)
                    takeTurn(@player)
            end
            @board.setAllAttacking
            @piece.last_turn = @board.turn
            @board.turn += 1
            @board.checkCheck
            @board.refresh
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
        sleep(1.5)
        35.times do
            puts "\n"
            sleep(0.08)
        end
        puts "               [/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/]"
        sleep(0.08)
        puts "               |/|                           Rules:                                 |/|"
        sleep(0.08)
        puts "               |/|                                                                  |/|"
        sleep(0.08)
        puts "               |/|    To move a piece, enter  the location of the piece to move     |/|"
        sleep(0.08)
        puts "               |/|    then 'to', then the location to move it to.                   |/|"
        sleep(0.08)
        puts "               |/|                                                                  |/|"
        sleep(0.08)
        puts "               |/|    EX:   'a7 to a5'  moves black pawn at A7 two forward to A5    |/|"
        sleep(0.08)
        puts "               |/|                                                                  |/|"
        sleep(0.08)
        puts "               |/| To perform a 'Castling' or 'En Passant move, just enter the move |/|"
        sleep(0.08)
        puts "               |/|   as usual, and the special move will be performed if valid      |/|"
        sleep(0.08)
        puts "               |/|                                                                  |/|"
        sleep(0.08)
        puts "               |/|       Enter: 'save' to save current game,                        |/|"
        sleep(0.08)
        puts "               |/|              'load' to load last save                            |/|"
        sleep(0.08)
        puts "               |/|         and 'reset' to reset the board                           |/|"
        sleep(0.08)
        puts "               |/|                                                                  |/|"
        sleep(0.08)
        puts "               [/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/][/]"
        sleep(0.08)
        5.times do
            puts "\n"
            sleep(0.08)
        end     
        sleep(3.5)
        30.times do
            puts "\n"
            sleep(0.08)
        end    
    end
end





game = Game.new
   
