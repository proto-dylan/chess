require 'colorize'

class ChessGame
    def initialize
        board = Board.new
        board.display
        
    end
    class Piece
        attr_accessor :type_of_piece, :init
        def initialize(type)
            @type_of_piece = type
            @init = type[0]
            puts "init: #{@init}"
        end
    end
    

    class Board
        attr_accessor :boardArray
        def initialize 
            @boardArray =  Array.new(8) {Array.new(8,0)}
            set_board
        end
        def set_board
            

            @br1, @br2, @wr1, @wr2 = [Piece.new('rook')] * 4
            /bk1, bk2, wk1, wk2 = ['k'] * 4
            bb1, bb2, wb1, wb2 = ['b'] * 4
            bQq, wQq = ['Q'] * 2
            bKk, wKk = ['K'] * 2
            bp1, bp2, bp3, bp4, bp5, bp6, bp7, bp8, wp1, wp2, wp3, wp4, wp5, wp6, wp7, wp8 = ['p'] * 16/
            
            puts "rook?   : #{@br1.init}"
            /startArray = [
              [br1,bk1,bb1,bQq,bKk,bb2,bk2,br2],
              [bp1,bp2,bp3,bp4,bp5,bp6,bp7,bp8],
              [0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0],
              [wp1,wp2,wp3,wp4,wp5,wp6,wp7,wp8],
              [wr1,wk1,wb1,wKk,wQq,wb2,wk2,wr2]
            ]/

            /@boardArray = startArray
            simple_print /
        end
        def simple_print
            puts "\n\n\n\n\n\n"
            counter = 8
            @boardArray.each do |row| 

                puts "        #{counter}|     #{row.join("     ")}"
                puts "\n\n"
                
                counter -=1
            end
            puts "               _     _     _     _     _     _     _     _"
            puts "               a     b     c     d     e     f     g     h"
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
                        if toggle == 1
                            print "  #{@boardArray[row][col]}   ".on_light_blue
                            toggle = 0
                        else
                            print "  #{@boardArray[row][col]}   ".on_light_black
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
    end
end
game = ChessGame.new
