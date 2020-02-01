require 'colorize'

class ChessGame
    def initialize
        board = Board.new
        
        
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
    

    class Board
        attr_accessor :boardArray
        def initialize 
            @boardArray =  Array.new(8) {Array.new(8,0)}
            set_board
        end
        def set_board
            

            @br1, @br2= [Piece.new(
                type_of_piece: 'rook',
                color: "black",
                uni: "\u265C"
                )] * 2
            @wr1, @wr2= [Piece.new(
                type_of_piece: 'rook',
                color: "white",
                uni: "\u265C"
                )] * 2
            @bk1, @bk2= [Piece.new(
                type_of_piece: 'knight',
                color: "black",
                uni: "\u265E"
                )] * 2
            @wk1, @wk2= [Piece.new(
                type_of_piece: 'knight',
                color: "white",
                uni: "\u265E"
                )] * 2
            

            



            /@wr1, @wr2 
            @br1[:uni] = "\u265C"
            @br2[:uni] = "\u265C"/
            /(@wr1, @wr2)[:uni] = "\u2656"
            bk1, bk2, wk1, wk2 = ['knight'] * 4
            bb1, bb2, wb1, wb2 = ['bishop'] * 4
            bQq, wQq = ['Q'] * 2
            bKk, wKk = ['K'] * 2
            bp1, bp2, bp3, bp4, bp5, bp6, bp7, bp8, wp1, wp2, wp3, wp4, wp5, wp6, wp7, wp8 = ['p'] * 16/
tempArray = [
            [@br1,@bk1,0,0,0,0,@wr1,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,@wk1,@wr1]
        ]
            
            
            

            startArray = [
              [@br1,@bk1,@bb1,@bQq,@bKk,@bb2,@bk2,@br2],
              [@bp1,@bp2,@bp3,@bp4,@bp5,@bp6,@bp7,@bp8],
              [0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0],
              [@wp1,@wp2,@wp3,@wp4,@wp5,@wp6,@wp7,@wp8],
              [@wr1,@wk1,@wb1,@wKk,@wQq,@wb2,@wk2,@wr2]
            ]

            @boardArray = tempArray
            
            displaySmall
            simple_print
        end
        def simple_print
            puts "\n\n\n\n"
            counter = 8
            row = 0
            col = 0

            8.times do
                print "                 #{counter}|  "
                counter -=1
                8.times do
                    if @boardArray[row][col] == 0
                        print "0 "
                    else
                        print "#{@boardArray[row][col].init} "
                    end
                    col +=1

                end
                puts "\n"
                col = 0
                row +=1
            end

            puts "                    _ _ _ _ _ _ _ _"
            puts "                    a b c d e f g h"
            puts "\n\n"
        end
        def display
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
            counter = 8
            toggle = 0
            8.times do |row|
                print "              "
                8.times do |col| 
                    if toggle == 1
                       
                        print "      ".on_light_blue
                        toggle = 0
                    else
                        print "      ".on_light_black
                        toggle = 1
                    end
                end
                puts "\n"
                print "            #{counter} "
                counter -=1
                8.times do |col| 
                    
                    if @boardArray[row][col] != 0
                        color_now = "#{@boardArray[row][col].color}"
                        if toggle == 1
                            if color_now == "black"
                                print "  #{@boardArray[row][col].uni}   ".black.on_light_blue
                            else
                                print "  #{@boardArray[row][col].uni}   ".white.on_light_blue
                            end
                            toggle = 0
                        else
                            if color_now == "black"
                                print "  #{@boardArray[row][col].uni}   ".black.on_light_black
                            else 
                                print "  #{@boardArray[row][col].uni}   ".white.on_light_black
                            end
                            toggle = 1
                        end
                    else
                        if toggle == 1
                            
                            print "      ".on_light_blue
                            toggle = 0
                        else
                            print "      ".on_light_black
                            toggle = 1
                        end
                    end
                end
                puts "\n"
                print "              "
                8.times do |col|
                    if toggle == 1
                       
                        print "      ".on_light_blue
                        toggle = 0
                    else
                        print "      ".on_light_black
                        toggle = 1
                    end
                   
                end
                toggle +=1
                puts "             "
            end
             
            puts "                 A     B     C     D     E     F     G     H"
            puts "\n\n\n\n\n"
        end
        def displaySmall
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
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
                    if @boardArray[row][col] != 0
                        color_now = "#{@boardArray[row][col].color}"
                        if toggle == 1
                            if color_now == "black"
                                print "#{@boardArray[row][col].uni} ".black.on_light_blue
                            else
                                print "#{@boardArray[row][col].uni} ".white.on_light_blue
                            end
                            toggle = 0
                        else
                            if color_now == "black"
                                print "#{@boardArray[row][col].uni} ".black.on_light_black
                            else 
                                print "#{@boardArray[row][col].uni} ".white.on_light_black
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
            puts "\n\n\n\n\n"
        end
    end
end
game = ChessGame.new
