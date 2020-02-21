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
     
    def load_game(loaded_game=nil)
        if loaded_game == nil
            loaded_game = File.read("SavedGames/save_game.yaml")
        else
            loaded_game = File.read("TempFiles/temp.yaml")
        end
        game = YAML.load(loaded_game)
        @player = game[:player]
        @board = game[:board]
        @win = game[:win]
    end

    def save_game(filename=nil)
        Dir.mkdir("SavedGames") unless Dir.exists?("SavedGames")
        if filename == nil
            filename = "SavedGames/save_game.yaml"
        else
            Dir.mkdir("TempFiles") unless Dir.exists?("TempFiles")
            filename = "TempFiles/temp.yaml"
        end
        hash = { :player => @player, :board => @board, :win => @win}  
        dump = YAML::dump(hash)
        File.open(filename, 'w') do |file|
            file.write(dump)
        end 
    end

    def play 
        @win = false 
        until @win do 
            save_game('in_check')
            @board.setAllAttacking
            in_check = @board.checkCheck(@player)
            if in_check == true
                puts "IN CHECK"
                
                if checkMate(@player)
                    @win = true
                end
                load_game('in_check')
            end

            takeTurn(@player) 
            if @player == 'black' && @win != true
                @player = 'white' 
            elsif @player == 'white' && @win != true
                @player = 'black'
            end
            
        end
    end

    def getCheckTeam(player)
        team = []
        col=0
        row=0
        8.times do
            8.times do
                if @board.board_array[row][col] != 0
                    piece = @board.board_array[row][col]
                    if piece.color != player      
                        team << piece
                    end              
                end
                col +=1 
            end
            col = 0
            row +=1
        end
        return team
    end

    def checkMate(player) #Checks all possible moves a player could take to see if check_mate is true
        load_game('in_check')
        board = @board
        board.assignLocations

        if player == 'black'
            color = 'white'
        else
            color = 'black'
        end
        team = getCheckTeam(color)
        check_mate = true 
        moves = []                      #true unless a piece can be played
        team.each do |piece|

            moves = []
            #puts "piece in checkMate :#{piece.type}, #{piece.color}"
            if piece.type == 'pawn' || piece.type == 'knight' || piece.type == 'king'
            #    if piece.type == 'pawn' 
            #        temp = piece.attacking 
            #        temp.each do |move|
            #            moves << move
            #        end
            #        temp = piece.moves
            #        temp.each do |move|
            #            moves << move
            #        end
            #    elsif piece.type == 'knight' 
            #        temp = piece.moves                   
            #    elsif piece.type == 'king'
            #        temp = piece.moves
            #    end
            #    moves.each do |move|
            #        if board.depth(move) > 1
            #            move.flatten!(1)
            #        end
            #    end
            #    temp.each do |move|
            #        travel = [(move[0]+piece.location[0]),(move[1]+piece.location[1])]
            #        if board.is_valid_move?(travel)
            #            moves << move
            #        end
            #    end
            else
                moves = board.getPossibleMoves(piece)
            end

            if board.depth(moves) > 2
                moves.flatten!(1)
            end  
            puts "MOVES : #{moves}"

            if moves != nil
                moves.each do |move|
                    load_game('in_check')
                    board = @board
                    board.displayBoard(board.board_array)
                    board.assignLocations
                    puts "PIECE: #{piece.type}, loc #{piece.location}"
                    if board.is_valid_move?(move)
                        piece_coords = piece.location
                        travel = [(move[0]-piece_coords[0]),(move[1]-piece_coords[1])]
                        puts "in CHECKMATE: piece: #{piece.type}, #{piece.color}, loc  #{piece_coords}, travel #{travel} move: #{move}"

                        if piece.type == 'knight'
                            check_move = "knight"
                        else
                            check_move = board.checkMove(travel, piece, move)            #checks if move is within moves allowed
                        end
                        
                        puts "CHECK MOVE: #{check_move}"
                        check_placement = checkPlacement(check_move, piece, move, piece_coords, travel, board)
                        #puts "check_placement: #{check_placement}"
                        if check_placement[0] != true
                        #    puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
                            board.simplePrint
                        end
                        #@board.refresh
                        
                        board.setAllAttacking
                        in_check = board.checkCheck(@player)
                        puts "_______________________________________________________________________________________"
                        puts "in check? #{in_check}"
                        if in_check == false
                            check_mate = false
                            return check_mate
                        end
                        piece.location = piece_coords
                                          
                    end
                    load_game('in_check')
                    board = @board
                    board.displayBoard(board.board_array)
                    board.assignLocations  
                end
            end

            board.setAllAttacking
            in_check = board.checkCheck(@player)

            if in_check == false
                check_mate = false
                return check_mate
            end
        end
        load_game('in_check')
        return check_mate
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

    def checkPlacement(check_move, piece, move, piece_coords, travel, board = @board)
        take_turn = false
        error = 0
        board_array = board.board_array
        case check_move
            when "check"
                error = 4
                take_turn = true
            when "castle"
                board.placeCastle(piece, move)
            when "attack"
                board.pawnAttack(piece, move)
            when "promotion"
                promo = board.promotion(piece, move)
                piece = promo
                board.placePiece(piece, move, board_array)    
            when "attack promotion"
                piece = board.promotion(piece, move)
                board.pawnAttack(piece, move)
            when "passant"
                board.passant(travel, piece)
            when "knight"
                check_knight = board.knightCheck(piece, move, travel)
                case check_knight 
                    when 1
                        attack = 1
                        board.placePiece(piece, move, board_array, attack)
                        piece.move_counter += 1 
                    when 0
                        board.placePiece(piece, move, board_array)
                        piece.move_counter += 1
                    when -1
                        error = 2
                        take_turn = true
                    when -2
                        error = 1
                        take_turn = true
                end    
            when "valid"
                to_move = true
                temp = board.buildPath(piece_coords, move, travel)
                path = temp[0]
                type = piece.type
                color = piece.color
                to_move = board.checkPath(path, piece_coords, color) 
                case to_move
                    when 0               #place          
                        board.placePiece(piece, move, board_array)
                        piece.move_counter += 1 
                    when -1              #error
                        error = 1
                        take_turn = true
                    when 1      
                        attack = 1
                        board.placePiece(piece, move, board_array, attack)
                        piece.move_counter += 1            
                end
            when "invalid"
                error = 1
                take_turn = true
        end
        return take_turn, error
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
                check_move = @board.checkMove(travel, @piece, @move)            #checks if move is within moves allowed
            end 

            check_placement = checkPlacement(check_move, @piece, @move, piece_coords, travel)
            error = check_placement[1]
            if error != 0
                @board.displayError(error)
            end
            if check_placement[0] == true
                takeTurn(@player)
            end
            
            @board.setAllAttacking

            still_in_check = @board.checkCheck(player)
            if still_in_check == true
                puts "STill in check"
                @board.displayError(6)
                load_game('in_check')
                @board.refresh
                takeTurn(@player)
            end

            @piece.last_turn = @board.turn
            @board.turn += 1
            #@board.checkCheck(player)
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
   
