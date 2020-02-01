require 'colorize'

class Chess
    def initialize
        game = Game.new       
    end
    class Piece
        attr_accessor :type_of_piece, :init, :uni, :color
        def initialize(
            type_of_piece:,
            uni:,
            color:
        )

        @type_of_piece = type_of_piece
        @init = type_of_piece[0]
        @uni = uni
        @color = color
        end
    end

    class Game
        attr_accessor :board_array
        def initialize
            board = Board.new
        end

    end
    
    class Board
        attr_accessor :board_array
        def initialize 
            setBoard
            refresh
        end
        def setBoard
            @br1, @br2 = [Piece.new(
                type_of_piece: 'rook',
                color: "black",
                uni: "\u265C"
                )] * 2
            @wr1, @wr2 = [Piece.new(
                type_of_piece: 'rook',
                color: "white",
                uni: "\u265C"
                )] * 2
            @bk1, @bk2 = [Piece.new(
                type_of_piece: 'knight',
                color: "black",
                uni: "\u265E"
                )] * 2
            @wk1, @wk2 = [Piece.new(
                type_of_piece: 'knight',
                color: "white",
                uni: "\u265E"
                )] * 2
            @bb1, @bb2 = [Piece.new(
                type_of_piece: 'bishop',
                color: "black",
                uni: "\u265D"
                )] * 2
            @wb1, @wb2 = [Piece.new(
                type_of_piece: 'bishop',
                color: "white",
                uni: "\u265D"
                )] * 2
            @bp1, @bp2, @bp3, @bp4, @bp5, @bp6, @bp7, @bp8 = [Piece.new(
                type_of_piece: 'pawn',
                color: "black",
                uni: "\u265F"
                )] * 8
            @wp1, @wp2, @wp3, @wp4, @wp5, @wp6, @wp7, @wp8= [Piece.new(
                type_of_piece: 'pawn',
                color: "white",
                uni: "\u265F"
                )] * 8
            @wQq = Piece.new(
                type_of_piece: 'Queen',
                color: "white",
                uni: "\u265B"
            )
            @bQq = Piece.new(
                type_of_piece: 'Queen',
                color: "black",
                uni: "\u265B"
            )
            @wKk = Piece.new(
                type_of_piece: 'King',
                color: "white",
                uni: "\u265A"
            )
            @bKk = Piece.new(
                type_of_piece: 'King',
                color: "black",
                uni: "\u265A"
            )              
             
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
            puts "              _ _ _ _ _ _ _ _"
            puts "              a b c d e f g h"
            puts "\n\n"
        end

        def refresh
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
            displaySmall
            simplePrint
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
end

game = Chess.new