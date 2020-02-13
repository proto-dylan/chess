class Board
    attr_accessor :board_array, :black_dead, :white_dead, :promotions

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
    @@input_keys = {'a' => 0,'b' => 1,'c' => 2,'d' => 3,'e' => 4,'f' => 5,'g' => 6,'h' => 7,1 => 7,2 => 6,3 => 5,4 => 4,5 => 3,
        6 => 2,7 => 1,8 => 0}
    
    def initialize 
        makePieces
        setBoard
        assignStartingLocations
        #refresh
        #simplePrint
        @white_dead = []
        @black_dead = []
        @promotions = 3                    #start count higher than any existing piece instance name
    end

    class Node        
        attr_accessor :position, :parent, :children
            def initialize (position, parent = nil, children = [])
                @position = position
                @parent = parent
                @children = []
            end  
    end

    def makePiece(type, color, uni, moves=0, move_counter=0, attacking=[])
      piece = Piece.new(
            type: type,
            color: color,
            uni: uni,
            moves: moves,
            move_counter: move_counter,
            attacking: attacking
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

    def setBoard(array=nil)
        if array.nil?     
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
        else
            @board_array = array
        end
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
    

    #def buildTree
    #    destination = @move
    #    moves = piece.moves
    #    position = piece.location
    #    root =  Node.new(position) 
    #    root_node = [root]
    #    col = position[0]
    #    row = position[1]
    #    path = []
    #    while not root_node.empty? && path.empty?         
    #        parent_node = root_node.shift
    #        moves.each do |move|
    #            if is_valid_move?(move, col, row)                  
    #                current = [parent_node.position[0]+move[0], parent_node.position[1]+move[1]]
    #                child = Node.new(current, parent_node)
    #                parent_node.children.push(child)
    #                root_node.push(child)                 
    #                if parent_node.position == destination                       
    #                    while not parent_node.nil?
    #                        path.push(parent_node.position)
    #                        parent_node = parent_node.parent
    #                    end
    #                    return path.reverse
    #                end
    #            end
    #        end 
    #    end    
    #end 
    
    def buildPath(location, destination, travel)
        path = []      
        counter_col = 0
        counter_row = 0
    
        if travel[1] == 0 
            if travel[0] > 0
                travel_temp = travel[0]               #move down the board
                counter_row = 1   
            elsif travel[0] < 0 
                travel_temp = (travel[0]).abs         #move up the board
                counter_row = -1
            end
        elsif travel[0] == 0 
            if travel[1] > 0
                travel_temp = travel[1]                  #move right
                counter_col = 1       
            elsif travel[1] < 0
                travel_temp = (travel[1]).abs           #move left
                counter_col = -1          
            end
        elsif (travel[0]).abs == (travel[1]).abs
            travel_temp =  (travel[0]).abs    
            if travel[0] > 0 && travel[1] > 0
                counter_col = 1  
                counter_row = 1                                           #move diag down right
            elsif travel[0] > 0 && travel[1] < 0
                counter_col = -1
                counter_row = 1                                            #move down left
            elsif travel[0] < 0 && travel[1] > 0
                counter_col = 1
                counter_row = -1                            #move up right
            elsif travel[0] < 0 && travel[1] < 0
                counter_col = -1
                counter_row = -1                                                     #move up left
            end   
        end

        travel_temp.times do
            location[0] += counter_row
            location[1] += counter_col
            temp = [location[0],location[1]]
            path << temp    
        end
        puts "PATH: #{path}"
        return path
    end

    def is_valid_move?(move, row, col)        
         return ((move[0]+col) > -1) && ((move[0]+col) < 8) && ((move[1]+row) > -1) && ((move[1]+row) < 8) ? true : false
    end

    def checkPath(path, piece_coords, type, color)
        to_move = 0                         #  -1 means no place, 0 means place, 1 means attack
        if path[0].instance_of?(Array)       #Must check if its a nested array before iteration!
            path.each do |path_move|               
                if @board_array[path_move[0]][path_move[1]] != 0
                    if path_move == path.last
                        if @board_array[path_move[0]][path_move[1]].color != color  
                            to_move = 1 
                        end
                    else                                    #check if the piece is enemy
                        to_move = -1
                        return to_move
                    end
                end
            end
        else                                                    #if its just an array of two coords, [x,y]
            if path != piece_coords
                if @board_array[path[0]][path[1]] != 0
                    if @board_array[path[0]][path[1]].color != color
                        to_move = 1
                    else
                        to_move = -1
                    end
                end

            end
        end
        return to_move
    end

    def knightCheck(piece, move, travel)
        puts " move #{move}"
        if piece.moves.include?(travel)
            if @board_array[move[0]][move[1]] != 0 
                puts "BLOCKknight"
                if @board_array[move[0]][move[1]].color != piece.color
                    return 1
                else
                    return -2
                end
            else
                return 0
            end
        else
            return -1
        end
    end

    def convertCoords(coords)
        array = coords.split(//)
        temp = [] 
        temp[0] = @@input_keys[array[0]]
        temp[1] = @@input_keys[array[1].to_i]
        array = temp.reverse
        return array
    end

    def getMove(player)
        puts "#{player} move: "
        input = gets.chomp    
        if input.match(/[a-h][1-8][\s](\w*to\w*)[\s][a-h][1-8]/)
            input = input.split('to')
            @piece = input[0].rstrip
            @move = input[1].strip
        else
            return 0
        end
        return @piece, @move
    end

    def checkPassant(travel, piece)
        puts "CHECK PASSANT"
        current = piece.location
        adj = @board_array[current[0]][current[1]+travel[1]]
        if adj != 0 && adj.color != piece.color 
            if adj.type == 'pawn' 
                if adj.move_counter == 1
                    if adj.location[0] == 3 || adj.location[0]==4 
                        return true
                    end
                end
            end
        end
        return false
    end

    def passant(travel, piece)
        current = piece.location
        adj = @board_array[current[0]][current[1]+travel[1]]            #the piece to capture
        move_to = [(current[0]+travel[0]),(current[1]+travel[1])]       #the loc of the final position after passant
        piece.location = move_to                                        #set new piece loc
        @board_array[current[0]][current[1]] = 0                        #reset passed piece loc              
        @board_array[move_to[0]][move_to[1]] = piece                    
        piece.move_counter += 1
        dead = adj
        @board_array[adj.location[0]][adj.location[1]] = 0
        assignDead(dead)       
    end

    def checkMove(travel, piece)
        if piece.type == 'pawn'
            loc = piece.location
            if piece.color == 'black' 
                temp_row = 1
            else
                temp_row = -1
            end
            if travel == [temp_row,-1] || travel == [temp_row,1]  
                if checkPassant(travel, piece)
                    return "passant"
                else                                                
                    to_attack = @board_array[loc[0] + travel[0]][loc[1] + travel[1]]     
                    if  to_attack != 0                                                   #special case check for diag attacks not in "moves"
                        if to_attack.color != piece.color
                            if to_attack.location[0] == 0 || to_attack.location[0] == 7
                                return "attack promotion"
                            else
                                return "attack"
                            end
                        end 
                    end
                end
            elsif piece.move_counter == 0
                return piece.moves.include?(travel) ? "valid" : "invalid"
            else
                row = loc[0] + travel[0]
                if @board_array[row][loc[1]] == 0
                    if row == 7 || row == 0
                        return "promotion"
                    else
                        return piece.moves[0]==travel ? "valid" : "invalid"
                    end
                else
                    return "invalid"
                end
            end
        else
            return piece.moves.include?(travel) ? "valid" : "invalid"
        end
    end

    def pawnAttack(piece, attack)       
        current = piece.location
        puts "attack #{attack}"    
        to_attack = @board_array[attack[0]][attack[1]]
        piece.location = attack
        row = attack[0]
        col = attack[1]
        @board_array[current[0]][current[1]] = 0
        @board_array[row][col] = piece
        piece.move_counter += 1
        refresh       
        assignDead(to_attack)      
    end

    def assignDead(to_attack)
        dead = [to_attack.uni]
        if to_attack.color == 'white'
            @white_dead.push(dead)
        else
            @black_dead.push(dead)
        end     
    end
    
    def getTravel(move, piece) 
        loc = piece.location
        row = move[0]-loc[0]
        col = move[1]-loc[1]
        travel = [row,col]
        return travel
    end

    def placePiece(piece, move, attack=0)
        current = piece.location
        piece.location = move        
        row = move[0]
        col = move[1]
        to_attack = @board_array[row][col]
        @board_array[current[0]][current[1]] = 0
        @board_array[row][col] = piece
        refresh
        if attack == 1
            assignDead(to_attack)     
        end
        @piece.attacking = @board.setAttacking(@piece)
        puts "@piece.attacking: #{@piece.attacking}"
    end

    def promotion(piece, move)
        refresh
        color = piece.color
        loc = piece.location
        puts "Choose Promotion: "
        puts "  1) Queen"
        puts "  2) Bishop"
        puts "  3) Rook"
        puts "  4) Knight"
        answer = gets.chomp.to_i

        case answer

            when 1
                puts "choice 1"
                promo = "#{color[0]}Q#{(@promotions-1)}"
                puts "promo: #{promo}"
                promotion = makePiece("queen", color, "\u265B", @@queen_moves)
                puts "promotion #{promotion}"              
            when 2
                puts "choice 2"
                promo = "#{color[0]}b#{(@promotions-1)}"
                puts "promo: #{promo}"
                promotion = makePiece("bishop", color, "\u265D", @@bishop_moves)
                puts "promotion #{promotion}"
            when 3
                puts "choice 3"
                promo = "#{color[0]}r#{(@promotions-1)}"
                puts "promo: #{promo}"
                promotion = makePiece("rook", color, "\u265C", @@rook_moves)
                puts "promotion #{promotion}"
            when 4
                puts "choice 4"
                promo = "#{color[0]}k#{(@promotions-1)}"
                puts "promo: #{promo}"
                promotion = makePiece("knight", color, "\u265E", @@knight_moves)
                puts "promotion #{promotion}"
        end

        instance_variable_set("@#{promo}", promotion)
        promotion.location = loc    
  
        return promotion

    end
    
    def getPawnAttacking(loc, color) 
        attack = []
        col = loc[1]
        if color == 'white'
            row = ((loc[0]) - 1)
        else
            row = ((loc[0]) + 1)
        end
        cols =[col+1, col +-1]                   #if black pawn, add one to row for diag attack, -1 for white
        cols.each do |col| 
            if col > -1 && col < 9 
                attack << [row, col]
            end
        end                                 # make sure its iterating over arrays, not integers!!
        return attack
    end
    
    def buildPossiblesKnight(piece)
        moves = piece.moves
        loc = piece.location
        moves.each do |move|
        attack = []
            if (loc[0]+move[0]) > -1 && (loc[0]+move[0]) < 8
                if  (loc[1]+move[1]) > -1 && (loc[1]+move[1]) < 8 
                    attack << [(loc[0]+move[0]),(loc[1]+move[1])]
                end
            end
        end
        return attack
            
    end

    def buildPossiblesDiags


    end

    def buildPossiblesCardinal
 

    end
    
    def setAttacking(piece)
        if piece.type == 'knight'
            return buildPossiblesKnight(piece)
        end




    end

    def refresh
        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        #simplePrint
        
        display        
    end 

    def displayError(switch)
        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        case switch
        when 1
            puts "Error, invalid move"
        when 2
            puts "Error, piece blocked"
        when 3
            puts "Error, wrong color move"
        end
        sleep(1.3)
        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
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
    
    def display
        puts "\n\n\n"
        puts "              a b c d e f g h  "
        counter = 8
        toggle = 0
        toggle2 = 0
        8.times do |row|
            
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
                            print "#{@board_array[row][col].uni} ".black.on_light_black
                        else
                            print "#{@board_array[row][col].uni} ".white.on_light_black
                        end
                        toggle = 0
                    else
                        if color_now == "black"
                            print "#{@board_array[row][col].uni} ".black.on_light_blue
                        else 
                            print "#{@board_array[row][col].uni} ".white.on_light_blue
                        end
                        toggle = 1
                    end
                else
                    if toggle == 1
                        
                        print "  ".on_light_black
                        toggle = 0
                    else
                        print "  ".on_light_blue
                        toggle = 1
                    end
                end                   
            end 
            if toggle2 == 0
                toggle2 = 1
            else
                toggle2 = 0
            end
            puts " #{counter+1} "
            
        end  
                
        puts "              a b c d e f g h  "
        puts "\n\n"

        puts "DEATH TALLY: "
        puts " BLACK:  #{@black_dead}"
        puts " WHITE:  #{@white_dead}"
        puts "\n\n\n"
    end
end
