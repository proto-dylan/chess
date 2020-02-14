
require 'spec_helper'
require 'stringio'
require './lib/chess_piece.rb' 
require './lib/chess.rb'
require './lib/chess_board.rb'

describe "Game" do
    game = Game.new

    describe "#takeTurn" do
    board = Board.new
        it "starst" do
            array = [
                    [@br1,0,0,0,@bKk,@bb2,@bk2,@br2],
                    [0,@bp2,@bp3,@bp4,@bp5,@bp6,@bp7,@bp8],
                    [0,0,0,0,0,0,0,0],
                    [0,0,0,0,0,0,0,0],
                    [@wp1,0,0,0,0,0,0,0],
                    [0,0,0,0,0,0,0,0],
                    [0,@wp2,@wp3,@wp4,@wp5,@wp6,@wp7,@wp8],
                    [@wr1,0,0,0,@wKk,@wb2,@wk2,@wr2]
                ]
                board_array = board.setBoard(array)
                board.assignStartingLocations
            
        
        end
    end
            
end