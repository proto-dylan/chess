require 'colorize'

class ChessGame
    def initialize
        board = Board.new
        board.display
    end

    class Board
        def initialize 
            @boardGrid =  Array.new(8) {Array.new(8,0)}
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
                    if @boardGrid[row][col] != 0
                        if toggle == 1
                            print "  #{@boardGrid[row][col]}   ".on_light_blue
                            toggle = 0
                        else
                            print "  #{@boardGrid[row][col]}   ".on_light_black
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
