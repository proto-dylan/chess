class Board
    attr_accessor :board_array, :black_dead, :white_dead, :promotions, :turn, :castle, :all_attacking, :black_attacking, :white_attacking
    @@diagonals = [[-1,1],[1,1],[1,-1],[-1,-1]]
    @@cardinals = [[-1,0],[1,0],[0,-1],[0,1]]
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
        assignLocations
        setAllAttacking
        #refresh
        #simplePrint
        @white_dead = []
        @black_dead = []
        @promotions = 3          #start count higher than any existing piece instance name 
        @turn = 0 
        @castle = []
        @all_attacking = []
        @black_attacking = []
        @white_attacking = []
                         
    end

    class Node        
        attr_accessor :position, :parent, :children
            def initialize (position, parent = nil, children = [])
                @position = position
                @parent = parent
                @children = []
            end  
    end

    def makePiece(type, color, uni, moves=0, move_counter=0, attacking=[], last_turn=0)
      piece = Piece.new(
            type: type,
            color: color,
            uni: uni,
            moves: moves,
            move_counter: move_counter,
            attacking: attacking,
            last_turn: last_turn
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
                [@wr1,@wk1,@wb1,@wQq,@wKk,@wb2,@wk2,@wr2]
            ]   
        else
            @board_array = array
        end
        return @board_array
    end

    def assignLocations
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
    
    def buildPath(location, destination, travel)
        loc = location
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
            loc[0] += counter_row
            loc[1] += counter_col
            temp = [loc[0],loc[1]]
            path << temp    
        end
        #puts "BUILDPATH 2 loc = #{loc}"
        loc = [(destination[0]-travel[0]),(destination[1]-travel[1])]
       # puts "BUILDPATH 3 loc = #{loc}, path #{path}"
        return path, loc
    end

    def checkPath(path, piece_coords, color)
        to_move = 0                         #  -1 means no place, 0 means place, 1 means attack
        if path[0].instance_of?(Array)       #Must check if its a nested array before iteration!
            path.each do |path_move|
                if @board_array[path_move[0]][path_move[1]] != 0
                    if path_move == path.last
                        if @board_array[path_move[0]][path_move[1]].color != color  
                            to_move = 1 
                        else
                            to_move = -1
                            return to_move
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
        if piece.moves.include?(travel)
            if @board_array[move[0]][move[1]] != 0 
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
        if input == "save"
            return "save"
        elsif input == "load"
            return "load"
        elsif input == "reset"
            return "reset"
        elsif input.match(/[a-h][1-8][\s](\w*to\w*)[\s][a-h][1-8]/)
            input = input.split('to')
            @piece = input[0].rstrip
            @move = input[1].strip
        else
            return 0
        end
        return @piece, @move
    end

    def checkPassant(travel, piece)
        current = piece.location
        adj = @board_array[current[0]][current[1]+travel[1]]
        if adj != 0 && adj.color != piece.color 
            if adj.type == 'pawn' 
                if (@turn - adj.last_turn) == 1
                    if adj.color == 'black'
                        if adj.location[0] == 3
                            return true
                        end
                    elsif adj.color == 'white'
                        if adj.location[0] == 4
                            return true
                        end
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

    def checkMove(travel, piece, move = nil)
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
                    else
                        return "invalid"
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
        elsif piece.type == 'king'
            if travel[1] == -2 || travel[1] == 2
                return checkCastling(piece, travel[1]) ? "castle" : "invalid"
            elsif piece.moves.include?(travel)
                if piece.color == 'black'
                    temp_attacking = @white_attacking
                elsif piece.color == 'white'
                    temp_attacking = @black_attacking
                end
           
                if temp_attacking.include?(move) 
                    return "check"
                else
                    return "valid"
                end
            end
        else
            return piece.moves.include?(travel) ? "valid" : "invalid"
        end
    end

    def checkCastling(piece, travel_col)
        travel_col
        king = piece
        color = king.color
        loc = king.location
        castle = false
        if king.move_counter == 0 
            if color == 'black'
                row = 0
            else
                row = 7
            end
            if travel_col == -2                        
                rook = @board_array[row][0] 
                col_to_check = [1,2,3] 
                castle_col = [2,3]            #  column for final move , king first then rook
            elsif travel_col == 2
                rook = @board_array[row][7]
                col_to_check = [5,6]
                castle_col = [6,5]             # col for king then rook
            end 
            if rook.type == 'rook' && rook.move_counter ==0
                check_path = []
                col_to_check.each do |col|
                    check_path << [row,col]
                end
                if checkPath(check_path, loc, color) == 0
                    @castle = [[row,castle_col[0]],[row,castle_col[1]],[rook.location],[king.location]]
                    return 'castle'
                end
            end
        end
        return 'invalid'
    end

    def placeCastle(piece, move)
        rook_array = @castle[2].flatten
        king_array = @castle[3].flatten
        rook = @board_array[rook_array[0]][rook_array[1]]
        king = @board_array[king_array[0]][king_array[1]]
        king_move = @castle[0].flatten
        rook_move = @castle[1].flatten
        placePiece(king, king_move, @board_array)
        placePiece(rook, rook_move, @board_array)
    end

    def pawnAttack(piece, attack)       
        current = piece.location 
        to_attack = @board_array[attack[0]][attack[1]]
        piece.location = attack
        row = attack[0]
        col = attack[1]
        @board_array[current[0]][current[1]] = 0
        @board_array[row][col] = piece
        piece.move_counter += 1
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

    def placePiece(piece, move, board_array, attack=0)
        current = piece.location
        piece.location = move        
        row = move[0]
        col = move[1]
        to_attack = @board_array[row][col]
        board_array[current[0]][current[1]] = 0
        board_array[row][col] = piece
        if attack == 1
            assignDead(to_attack)     
        end      
    end

    def promotion(piece, move)
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
                promo = "#{color[0]}Q#{(@promotions-1)}"
                promotion = makePiece("queen", color, "\u265B", @@queen_moves)             
            when 2
                promo = "#{color[0]}b#{(@promotions-1)}"
                promotion = makePiece("bishop", color, "\u265D", @@bishop_moves)
            when 3
                promo = "#{color[0]}r#{(@promotions-1)}"
                promotion = makePiece("rook", color, "\u265C", @@rook_moves)
            when 4
                promo = "#{color[0]}k#{(@promotions-1)}"
                promotion = makePiece("knight", color, "\u265E", @@knight_moves)
        end
        instance_variable_set("@#{promo}", promotion)
        promotion.location = loc   
        return promotion
    end
    
   
   
    def is_valid_move?(move)        
        return (move[0] > -1) && (move[0] < 8) && (move[1] > -1) && (move[1] < 8) ? true : false
    end
    

    def checkCheck(color)
        col=0
        row=0
        8.times do
            8.times do
                if @board_array[row][col] != 0
                    piece = @board_array[row][col]
                    if piece.type == 'king' && piece.color == color        
                        loc = piece.location
                        if color == 'black'
                            king_attacking = @white_attacking               #assign oppisite side as the attacking array
                        elsif color == 'white'
                            king_attacking = @black_attacking
                        end
                       # puts "#{color} attacking(being attacked)!!! #{king_attacking}"
                        if king_attacking.include?(loc)
                            return true
                        end
                    end
                end
                col +=1 
            end
            col = 0
            row +=1
        end
        return false
    end

    def setAllAttacking         #piece to exclude in attack tally (coords)
        col=0
        row=0

        @all_attacking = []
        @black_attacking = []
        @white_attacking = []
        8.times do
            8.times do
                piece = @board_array[row][col]
                if piece != 0
                    attack = setAttacking(piece) 
                    if attack != nil
                        
                        piece.attacking << attack
                        @all_attacking << attack

                        if piece.color == 'black'
                            @black_attacking << attack
                        elsif piece.color == 'white'
                            @white_attacking << attack
                        end
                       # puts "color: #{piece.color}, piece: #{piece.type} attacking: #{piece.attacking}"
                    end
                end
                col +=1
            end
            col = 0
            row +=1            
        end

        @all_attacking.flatten!(1)
        @black_attacking.flatten!(1)
        @white_attacking.flatten!(1)

        #puts "all attacking #{@all_attacking}"
       # puts "black attack #{@black_attacking}"
        #puts "white attack #{@white_attacking}"
    end

   
    def setAttacking(piece)
        piece.attacking = []
        to_attack = [] 
        if piece.type == 'pawn'
            to_attack = getPawnAttacking(piece.location, piece.color)
        elsif piece.type == 'knight'
            to_attack = buildPossiblesKnight(piece)
        elsif piece.type == 'bishop'
            to_attack = buildPossibles(piece, @@diagonals)
        elsif piece.type == 'rook'
            to_attack = buildPossibles(piece, @@cardinals)
        elsif piece.type == 'queen'
            to_attack = ((buildPossibles(piece, @@diagonals))+(buildPossibles(piece, @@cardinals)))
        elsif piece.type == 'king'
            to_attack = getKingAttacking(piece)
        end
        
        return to_attack

    end

    def getKingAttacking(piece)
        array = (@@diagonals+@@cardinals)
        loc = piece.location
        attack = []
        array.each do |coord| 
            row = coord[0] + loc[0]
            col = coord[1] + loc[1]
            if is_valid_move?([row,col])
                temp_piece = @board_array[row][col]
                if temp_piece != 0  
                    if temp_piece.color != piece.color
                        attack << [row, col]
                    end
                elsif temp_piece == 0 
                    attack << [row, col]
                end
            end
        end   
        return attack 
    end

    def depth(xs, n=0)
        return case
        when xs.class != Array
          n
        when xs == []
          n + 1
        else
          xs.collect{|x| depth x, n+1}.max
        end
      end
    
    def getPawnAttacking(loc, color) 
        attack = []
        col = loc[1]
        if color == 'white'
            row = ((loc[0]) - 1)                    #if black pawn, add one to row for diag attack, -1 for white
        else
            row = ((loc[0]) + 1)
        end
        cols =[col+1, col +-1]                   
        cols.each do |col| 
            if is_valid_move?([row,col])
                temp_piece = @board_array[row][col]
                if temp_piece != nil
                    if temp_piece != 0  
                        if temp_piece.color != color
                            attack << [row, col]
                        end
                    elsif temp_piece == 0 
                        attack << [row, col]
                    end
                end
            end
        end                                 # make sure its iterating over arrays, not integers!!
        return attack
    end

    def buildPossibles(piece, array)
        loc = piece.location
        color = piece.color
        attack = [] 
        array.each do |coord|
            temp_attack = recursiveCheck(loc, coord, color)
            if temp_attack != nil && temp_attack != loc
                temp_piece = @board_array[temp_attack[0]][temp_attack[1]]
                if temp_piece != 0
                    if temp_piece.color != color
                        attack << temp_attack
                    end
                else
                    attack << temp_attack
                end
            end
        end
        return attack
    end

    def getPossibleMoves(piece)
        attacks = piece.attacking.flatten(1)
        loc = piece.location
        
        all_moves = []
       # puts "in get possibleMOves: #{attacks}"
        attacks.each do |attack|
            #puts "loc< #{loc}, piece.loc #{piece.location}"
            puts "attack: #{attack}"
            travel = [(attack[0]-loc[0]),(attack[1]-loc[1])]
            #puts  "IN!buildPath loc#{loc}, attack #{attack}, travel #{travel}"
            path = buildPath(loc, attack, travel)
            piece.location = path[1]
            loc = piece.location
            #puts "path at the end#{path[0]}"
            all_moves << path[0]
        end
        #puts "allmoves #{all_moves}"
        return all_moves.flatten!(1)
    end

    def recursiveCheck(loc, bump, color)
        current = loc
        temp =[(current[0]+bump[0]),(current[1]+bump[1])]
        temp2 = [(temp[0]+bump[0]),(temp[1]+bump[1])]
        if is_valid_move?(temp)
            temp_piece = @board_array[temp[0]][temp[1]]
            if temp_piece == 0 
                if is_valid_move?(temp2)
                    recursiveCheck(temp, bump, color)
                else
                    return temp
                end
            elsif temp_piece.color != color
                return temp
            else 
                return current
            end
        else
            return current
        end
    end

    def buildPossiblesKnight(piece)
        moves = piece.moves
        loc = piece.location
        attack = []
        moves.each do |move|
            row = loc[0]+move[0]
            col = loc[1]+move[1]
            if is_valid_move?([row,col])
                temp_piece = @board_array[row][col]
                if temp_piece != 0
                    if temp_piece.color != piece.color
                        attack << [row, col]
                    end
                else
                    attack << [row, col]
                end
            end
        end
        return attack     
    end

    def refresh
        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        #simplePrint 
        displayDead   
        displayBoard        
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
        when 4
            puts "Error, can't move king into check"
        when 5
            puts "Error, must move king out of check"
        when 6
            puts "Error, can't leave king in check"
        end
        sleep(1.3)
        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        refresh
    end

    def displayMessage(switch)
        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        case switch
        when 1
            puts "Game saving..."
        when 2
            puts "Game loading..."
        when 3
            puts "Board resetting..."
        end
        sleep(1)
        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
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

    def displayDead
        puts "                  captured "
        puts
        print "                  "
        print "black:  "
        @black_dead.flatten.each { |x| print "#{x}".black.on_light_blue} 
        puts ""   
        print "                  "
        print "white:  "
        @white_dead.flatten.each { |x| print "#{x}".white.on_light_black}
        puts "\n" 
    end
    
    def displayBoard(board_array = @board_array)
        puts "\n\n"
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
                if board_array[row][col] != 0
                    color_now = "#{board_array[row][col].color}"
                    if toggle == 1
                        if color_now == "black"
                            print "#{board_array[row][col].uni} ".black.on_light_black
                        else
                            print "#{board_array[row][col].uni} ".white.on_light_black
                        end
                        toggle = 0
                    else
                        if color_now == "black"
                            print "#{board_array[row][col].uni} ".black.on_light_blue
                        else 
                            print "#{board_array[row][col].uni} ".white.on_light_blue
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
        
    end
end
