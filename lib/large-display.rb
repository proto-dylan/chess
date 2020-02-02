def display
            
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
                    
                    if @board_array[row][col] != 0
                        color_now = "#{@board_array[row][col].color}"
                        if toggle == 1
                            if color_now == "black"
                                print "  #{@board_array[row][col].uni}   ".black.on_light_blue
                            else
                                print "  #{@board_array[row][col].uni}   ".white.on_light_blue
                            end
                            toggle = 0
                        else
                            if color_now == "black"
                                print "  #{@board_array[row][col].uni}   ".black.on_light_black
                            else 
                                print "  #{@board_array[row][col].uni}   ".white.on_light_black
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
            puts "\n\n"
        end