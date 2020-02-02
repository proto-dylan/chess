require 'colorize'

class Game
    attr_accessor :board_array
    def initialize
       
        board = Board.new
        
    end

end

class Piece
    attr_accessor :type, :init, :uni, :color, :moves, :location
    def initialize(
        type:,
        uni:,
        color:,
        moves: [],
        location: []
    )
    
    
    @type = type
    @init = type[0]
    @uni = uni
    @color = color
    @moves = moves
    @location = location
    end
end

class Board
    attr_accessor :board_array
    def initialize 
        makePieces
        setBoard
        assignStartingLocations
        refresh
        simplePrint
    end
    def makePiece(type, color, uni)
      piece = Piece.new(
            type: type,
            color: color,
            uni: uni
        )
        return piece
    end
    def makePieces
        
                
                                                            #make black team pieces
        @br1 = makePiece("rook", "black", "\u265C")
        @br2 = makePiece("rook", "black", "\u265C")
        @bk1 = makePiece("knight", "black", "\u265E")
        @bk2 = makePiece("knight", "black", "\u265E")
        @bb1 = makePiece("bishop", "black", "\u265D")
        @bb2 = makePiece("bishop", "black", "\u265D")
        @bp1 = makePiece("pawn", "black", "\u265F")
        @bp2 = makePiece("pawn", "black", "\u265F")
        @bp3 = makePiece("pawn", "black", "\u265F")
        @bp4 = makePiece("pawn", "black", "\u265F")
        @bp5 = makePiece("pawn", "black", "\u265F")
        @bp6 = makePiece("pawn", "black", "\u265F")
        @bp7 = makePiece("pawn", "black", "\u265F")
        @bp8 = makePiece("pawn", "black", "\u265F")
        @bQq = makePiece("queen", "black", "\u265B")
        @bKk = makePiece("king", "black", "\u265A")
                                                            #make white team pieces
        @wr1 = makePiece("rook", "white", "\u265C")
        @wr2 = makePiece("rook", "white", "\u265C")      
        @wk1 = makePiece("knight", "white", "\u265E")
        @wk2 = makePiece("knight", "white", "\u265E")       
        @wb1 = makePiece("bishop", "white", "\u265D")
        @wb2 = makePiece("bishop", "white", "\u265D")
        @wp1 = makePiece("pawn", "white", "\u265F")
        @wp2 = makePiece("pawn", "white", "\u265F")
        @wp3 = makePiece("pawn", "white", "\u265F")
        @wp4 = makePiece("pawn", "white", "\u265F")
        @wp5 = makePiece("pawn", "white", "\u265F")
        @wp6 = makePiece("pawn", "white", "\u265F")
        @wp7 = makePiece("pawn", "white", "\u265F")
        @wp8 = makePiece("pawn", "white", "\u265F")
        @wQq = makePiece("queen", "white", "\u265B")
        @wKk = makePiece("king", "white", "\u265A")


        
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


game = Game.new         #UN-COMMENT TO RUN WITHOUT RSPEC