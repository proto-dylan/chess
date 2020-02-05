require 'colorize'

class Game
    attr_accessor :board_array
    def initialize
    
        @board = Board.new
        #play
    end
    def play
        #welcome
        win = false
        until win do
            #player = "Black"
            @board.takeTurn
            
        end

    end
end

class Piece
    attr_accessor :type, :init, :uni, :color, :moves, :location, :moved
    def initialize(
        type:,
        uni:,
        color:,
        moves: [],
        location: [],
        moved: false
    )
    @type = type
    @init = type[0]
    @uni = uni
    @color = color
    @moves = moves
    @location = location
    end
    
    

    /def build_node_tree(piece, move)
        moves = piece.moves
        position = piece.location
        root =  Node.new(position) 
        root_node = [root]
        col = position[0]
        row = position[1]
        
        while not root_node.empty? && path.empty?
            parent_node = root_node.shift
            moves.each do |move|
                if is_valid_move?(move, col, row)
                    current = [parent_node.position[0]+move[0], parent_node.position[1]+move[1]]
                    child = Node.new(current, parent_node)
                    parent_node.children.push(child)
                    root_node.push(child)
                    if parent_node.position == move
                        while not parent_node.nil?
                            path.push(parent_node.position)
                            parent_node = parent_node.parent
                        end
                    end 
                end
            end 
        end 
    end/  
end

class Board

    class Node        
        attr_accessor :position, :parent, :children
            def initialize (position, parent = nil, children = [])
                @position = position
                @parent = parent
                @children = []
            end  
    end

    attr_accessor :board_array
    @@white_pawn_moves = [[-1,0],[-2,0]]
    @@black_pawn_moves = [[1,0],[2,0]]
    @@knight_moves = [[-1,2],[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1]]  

    @@bishop_moves = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[-1,1],[-2,2],
    [-3,3],[-4,4],[-5,5],[-6,6],[-7,7],[1,-1],[2,-2],[3,-3],[4,-4],[5,-5],
    [6,-6],[7,-7],[-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7]]

    @@rook_moves = [[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],[0,-1],[0,-2],
    [0,-3],[0,-4],[0,-5],[0,-6],[0,-7],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],
    [-1,0],[-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0]]

    @@queen_moves = [[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],[0,-1],[0,-2],
    [0,-3],[0,-4],[0,-5],[0,-6],[0,-7],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],
    [-1,0],[-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0],[1,1],[2,2],[3,3],[4,4],[5,5],
    [6,6],[7,7],[-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7],[1,-1],[2,-2],
    [3,-3],[4,-4],[5,-5],[6,-6],[7,-7],[-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7]]


    @@king_moves = [[1,0],[1,1],[0,1],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]   
    


    
    
    def initialize 
        makePieces
        setBoard
        assignStartingLocations
        #refresh
        #simplePrint
    end
    def makePiece(type, color, uni, moves=0)
      piece = Piece.new(
            type: type,
            color: color,
            uni: uni,
            moves: moves
        )
        return piece
    end
    def makePieces         
                                             #make black team pieces
        @br1 = makePiece("rook", "black", "\u265C", @@rook_moves)
        @br2 = makePiece("rook", "black", "\u265C", @@rook_moves)
        @bk1 = makePiece("knight", "black", "\u265E", @@knight_moves)
        @bk2 = makePiece("knight", "black", "\u265E", @@knight_moves)
        @bb1 = makePiece("bishop", "black", "\u265D", @@bishop_moves)
        @bb2 = makePiece("bishop", "black", "\u265D", @@bishop_moves)
        @bp1 = makePiece("pawn", "black", "\u265F", @@black_pawn_moves)
        @bp2 = makePiece("pawn", "black", "\u265F", @@black_pawn_moves)
        @bp3 = makePiece("pawn", "black", "\u265F", @@black_pawn_moves)
        @bp4 = makePiece("pawn", "black", "\u265F", @@black_pawn_moves)
        @bp5 = makePiece("pawn", "black", "\u265F", @@black_pawn_moves)
        @bp6 = makePiece("pawn", "black", "\u265F", @@black_pawn_moves)
        @bp7 = makePiece("pawn", "black", "\u265F", @@black_pawn_moves)
        @bp8 = makePiece("pawn", "black", "\u265F", @@black_pawn_moves)
        @bQq = makePiece("queen", "black", "\u265B", @@queen_moves)
        @bKk = makePiece("king", "black", "\u265A", @@king_moves)
                                                 #make white team pieces
        @wr1 = makePiece("rook", "white", "\u265C", @@rook_moves)
        @wr2 = makePiece("rook", "white", "\u265C", @@rook_moves)      
        @wk1 = makePiece("knight", "white", "\u265E", @@knight_moves)
        @wk2 = makePiece("knight", "white", "\u265E", @@knight_moves)       
        @wb1 = makePiece("bishop", "white", "\u265D", @@bishop_moves)
        @wb2 = makePiece("bishop", "white", "\u265D", @@bishop_moves)
        @wp1 = makePiece("pawn", "white", "\u265F", @@white_pawn_moves)
        @wp2 = makePiece("pawn", "white", "\u265F", @@white_pawn_moves)
        @wp3 = makePiece("pawn", "white", "\u265F", @@white_pawn_moves)
        @wp4 = makePiece("pawn", "white", "\u265F", @@white_pawn_moves)
        @wp5 = makePiece("pawn", "white", "\u265F", @@white_pawn_moves)
        @wp6 = makePiece("pawn", "white", "\u265F", @@white_pawn_moves)
        @wp7 = makePiece("pawn", "white", "\u265F", @@white_pawn_moves)
        @wp8 = makePiece("pawn", "white", "\u265F", @@white_pawn_moves)
        @wQq = makePiece("queen", "white", "\u265B", @@queen_moves)
        @wKk = makePiece("king", "white", "\u265A", @@king_moves)   
    end
    def reset
        board = Board.new
        return @board_array
    end
    def setBoard      
        @board_array = [
            [@br1,@bk1,@bb1,@bQq,@bKk,@bb2,@bk2,@br2],
            [@bp1,@bp2,@bp3,@bp4,@bp5,@bp6,@bp7,@bp8],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [@wp1,@wp2,@wp3,@wp4,@wp5,@wp6,@wp7,@wp8],
            [@wr1,@wk1,@wb1,@wKk,@wQq,@wb2,@wk2,@wr2]
        ]   
        return @board_array
    end
    def assignStartingLocations
        col=0
        row=0
        8.times do
            8.times do
                if @board_array[row][col] != 0           
                    @board_array[row][col].location = [row,col]          
                end
                col +=1
            end
            col = 0
            row +=1            
        end
        return @board_array
    end

    def buildPathTree(piece, move)
        puts "PIECE : #{piece},  type. #{piece.type}"
        destination = move
        moves = piece.moves
        position = piece.location
        root =  Node.new(position) 
        root_node = [root]
        col = position[0]
        row = position[1]
        path = []
        while not root_node.empty? && path.empty?
            puts " INSide buildpath : 1"
            parent_node = root_node.shift
            puts "moves: #{moves}"
            moves.each do |move|
                if is_valid_move?(move, col, row)
                    puts " INSide buildpath : 2"
                    current = [parent_node.position[0]+move[0], parent_node.position[1]+move[1]]
                    child = Node.new(current, parent_node)
                    parent_node.children.push(child)
                    root_node.push(child)
                    puts "pos : #{parent_node.position}  des:  #{destination}"
                    
                    if parent_node.position == destination
                        puts " INSide buildpath : 3"
                        while not parent_node.nil?
                            path.push(parent_node.position)
                            parent_node = parent_node.parent
                        end
                        puts "path: #{path.reverse}"
                        return path.reverse
                    end
                end
            end 
        end    
    end  

    def is_valid_move?(move, row, col)
        
         return ((move[0]+col) > -1) && ((move[0]+col) < 8) && ((move[1]+row) > -1) && ((move[1]+row) < 8) ? true : false
    end
    def takeTurn(player='black', valid=true)
        refresh
        piece = []
        move = []
        if valid == false
            puts "Invalid move"
        end
        move_coords = getMove(player)
        piece_coords = convertCoords(move_coords[0])
        piece = @board_array[piece_coords[0]][piece_coords[1]]     
        move = convertCoords(move_coords[1])
        possibles = buildPossibles(piece)
        if checkMove(piece, move)
            to_move = true
            path = buildPathTree(piece, move)
            path.each do |loc|
                temp_row = loc[0]
                temp_col = loc[1]
                if @board_array[loc[0]][loc[1]] != 0
                    to_move = false
                end
            end
            if to_move == true
                placePiece(piece, move)
            else
                valid = false
                takeTurn(player, valid)
            end
        else
            valid = false
            takeTurn(player, valid)
        end
    end
    def convertCoords(coords)
        coord_array = coords.split(',').map(&:to_i)
        return coord_array
    end

    def getMove(player)
        puts "#{player} turn"
        puts "Piece to move ('row,col'): "
        piece = gets.chomp
        puts "To ('row,col'): "
        move = gets.chomp
        return piece, move
    end
   # /def buildPossibles(piece)
    #possibles = []
    #moves = piece.moves
    #current_row = piece.location[0]
    #current_col = piece.location[1] 
   # moves.each do |move|
    #    temp_row = (current_row - move[0])
    #    temp_col = (current_col - move[1])
    #    if (temp_row > -1) && (temp_row < 8) && (temp_col > -1) && (temp_col < 8)
    #        possibles << [temp_row, temp_col]
    #    end
   # end
    #return possibles
    #end/

    def checkMove(piece, move)
            
            row = move[0]-piece.location[0]
            col = move[1]-piece.location[1]
            travel = [row,col]
            return piece.moves.include?(travel) ? true : false
    end
    def placePiece(piece, loc)
        current = piece.location
        piece.location = loc        
        row = loc[0]
        col = loc[1]
        temp_row = current[0]
        temp_col = current[1]
        @board_array[temp_row][temp_col] = 0
        @board_array[row][col] = piece
        refresh
    end
    def simplePrint       
        puts "\n\n"
        counter = 8
        row = 0
        col = 0
        8.times do
            print "           #{counter}|  "
            counter -=1
            8.times do
                if @board_array[row][col] == 0
                    print "0 "
                else
                    print "#{@board_array[row][col].init} "
                end
                col +=1
            end
            puts "\n"
            col = 0
            row +=1
        end
        puts "               _ _ _ _ _ _ _ _"
        puts "               a b c d e f g h"
        puts "\n\n"
    end
    def refresh
        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        displaySmall
        /simplePrint/
    end 
    def displaySmall
        puts "\n\n\n\n\n"
        counter = 8
        toggle = 0
        toggle2 = 0
        8.times do |row|
            puts "\n"
            print "            #{counter} "
            counter -=1
            if toggle2 == 1 
                toggle = 1
            elsif toggle2 == 0
                toggle = 0
            end
            8.times do |col|                     
                if @board_array[row][col] != 0
                    color_now = "#{@board_array[row][col].color}"
                    if toggle == 1
                        if color_now == "black"
                            print "#{@board_array[row][col].uni} ".black.on_light_blue
                        else
                            print "#{@board_array[row][col].uni} ".white.on_light_blue
                        end
                        toggle = 0
                    else
                        if color_now == "black"
                            print "#{@board_array[row][col].uni} ".black.on_light_black
                        else 
                            print "#{@board_array[row][col].uni} ".white.on_light_black
                        end
                        toggle = 1
                    end
                else
                    if toggle == 1
                        
                        print "  ".on_light_blue
                        toggle = 0
                    else
                        print "  ".on_light_black
                        toggle = 1
                    end
                end                   
            end 
            if toggle2 == 0
                toggle2 = 1
            else
                toggle2 = 0
            end
        end  
        puts "\n"          
        puts "              a b c d e f g h  "
        puts "\n\n\n"
    end
end


game = Game.new
   
