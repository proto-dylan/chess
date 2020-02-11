
require 'spec_helper'

require './lib/chess_piece.rb' 
require './lib/chess.rb'
require './lib/chess_board.rb'




describe Board do 
    subject(:board) {Board.new}       
    context '#setBoard' do
        it "creates 8X8 board" do
            expect(board.setBoard.length).to eql(8)            
        end 
        it  "has a black rook in @board_array[0][0]" do
            array=board.setBoard
            expect(array[0][0]).to be_instance_of(Piece) 
            expect(array[0][0].init).to eql("r")
            expect(array[0][0].type).to eql("rook") 
            expect(array[0][0].color).to eql("black")
        end
       it "assigns starting locations" do
            array=board.assignStartingLocations
            expect(array[0][7].location).to eql([0,7]) 
            expect(array[0][1].location).to eql([0,1]) 
            expect(array[1][7].location).to eql([1,7])
            expect(array[1][1].location).to eql([1,1]) 
            expect(array[1][1].location).to eql([1,1]) 
            expect(array[6][1].location).to eql([6,1]) 
        end
        it "assigns moves to pawns" do
            array=board.setBoard
            expect(array[6][0].moves).to eql([[-1,0],[-2,0]])
        end
    end
    context "#placePiece" do
        board = Board.new
        array=board.setBoard
       #puts "array: #{array[0][0]}"
        it "moves rook " do
            board.placePiece(array[0][0], [2,2])
            expect(array[2][2].init).to eql('r')
        end
        it "moves knight" do
            board.placePiece(array[0][1], [3,3])
            expect(array[3][3].init).to eql('k')
        end
        it "leaves last place empty" do
            expect(array[0][0]).to eql(0)
        end       
    end
    it "resets the board" do
        array=board.reset
   
        expect(array[0][0].init).to eql('r')    
    end
    context '#checkMove' do       ###Rec=factored to accept a 'Travel' array, not the 'move' itself
    subject(:board) {Board.new} 
        it "returns true if valid pawn move" do
            array=board.setBoard
            piece = array[1][1]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([2,0], piece)
            expect(val).to be true
        end
        it "returns false if the pawn move is invalid" do
            array=board.setBoard
            piece = array[1][1]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([2,2], piece)
            expect(val).to be false
        end
        it "returns false if Kinght move is invalid" do
            array=board.setBoard
            piece = array[0][1]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([2,4], piece)
            expect(val).to be false
        end
        it "returns true if Kinght move is valid" do
            array=board.setBoard
            piece = array[0][1]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([2,-1], piece)
            expect(val).to be true
        end
        it "returns true for bishop move" do
            array=board.setBoard
            piece = array[0][2]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([-2,2], piece)
            expect(val).to be true
        end
        it "returns false for bishop move" do
            array=board.setBoard
            piece = array[0][2]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([1,4], piece)
            expect(val).to be false
        end
        it "returns true for rook move" do
            array=board.setBoard
            piece = array[0][0]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([0,4], piece)
            expect(val).to be true
        end
        it "returns false for rook move" do
            array=board.setBoard
            piece = array[0][0]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([1,4], piece)
            expect(val).to be false
        end
        it "returns true for queen move" do
            #puts "QHEEEEEENN"
            array=board.setBoard
            piece = array[0][3]
           # puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([4,4], piece)
            expect(val).to be true
        end
        it "returns false for queen move" do
            #puts "QHEEEEEENN"
            array=board.setBoard
            piece = array[0][3]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([1,3], piece)
            expect(val).to be false
        end
        it "returns false for king" do
            array=board.setBoard
            piece = array[0][4]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([1,4], piece)
            expect(val).to be false
        end
        it "returns true for king" do
            array=board.setBoard
            piece = array[0][4]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove([1,0], piece)
            expect(val).to be true

        end

    end 
    context "#buildPath" do
    subject(:board) {Board.new} 
        it "returns an array do" do
            array=board.setBoard

            piece = array[1][1]

            loc = piece.location
            dest = [3,1]
            travel = [2,0]
            
            path = board.buildPath(loc, dest, travel)
            expect(path).to be_instance_of(Array)

        end
       
    end
    context "#checkPath" do
        subject(:board) {Board.new}
     
        it "returns false if the rook is impeded" do
            
            array = [
                [0,@bk1,@bb1,@bQq,@bKk,@bb2,@bk2,@br2],
                [0,@bp2,@bp3,@bp4,@bp5,@bp6,@bp7,@bp8],
                [0,0,0,0,0,0,0,0],
                [@br1,0,0,0,0,0,0,0],
                [@wp1,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,@wp2,@wp3,@wp4,@wp5,@wp6,@wp7,@wp8],
                [@wr1,@wk1,@wb1,@wKk,@wQq,@wb2,@wk2,@wr2]
            ]
            board_array = board.setBoard(array)
            loc = [3,0]
            dest = [5,0]
            travel = [2,0]
            path = [[4,0],[5,0]]

            check = board.checkPath(path, loc, 'rook')

            expect(check).to eql(-1)
        end
        it "returns true if the rook move is valid and free" do
            
            array = [
                [0,@bk1,@bb1,@bQq,@bKk,@bb2,@bk2,@br2],
                [0,@bp2,@bp3,@bp4,@bp5,@bp6,@bp7,@bp8],
                [0,0,0,0,0,0,0,0],
                [@br1,0,0,0,0,0,0,0],
                [@wp1,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,@wp2,@wp3,@wp4,@wp5,@wp6,@wp7,@wp8],
                [@wr1,@wk1,@wb1,@wKk,@wQq,@wb2,@wk2,@wr2]
            ]
            board_array = board.setBoard(array)
            loc = [3,0]
            dest = [0,0]
            travel = [-3,0]
            path = [[2,0],[1,0],[0,0]]

            check = board.checkPath(path, loc, 'rook')

            expect(check).to eql(0)
        end
    
    
        it "returns false if the pawn is impeded" do
            
            array = [
                [0,@bk1,@bb1,@bQq,@bKk,@bb2,@bk2,@br2],
                [0,@bp2,@bp3,@bp4,@bp5,@bp6,@bp7,@bp8],
                [0,0,0,0,0,0,0,0],
                [@br1,0,0,0,0,0,0,0],
                [@wp1,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,@wp2,@wp3,@wp4,@wp5,@wp6,@wp7,@wp8],
                [@wr1,@wk1,@wb1,@wKk,@wQq,@wb2,@wk2,@wr2]
            ]
            board_array = board.setBoard(array)
            loc = [4,0]
            dest = [3,0]
            travel = [-1,0]
            path = [3,0]

            check = board.checkPath(path, loc, 'pawn')

            expect(check).to eql(-1)
        end

        it "returns true if the pawn isnt impeded" do
            
            array = [
                [0,@bk1,@bb1,@bQq,@bKk,@bb2,@bk2,@br2],
                [0,@bp2,@bp3,@bp4,@bp5,@bp6,@bp7,@bp8],
                [0,0,0,0,0,0,0,0],
                [@br1,0,0,0,0,0,0,0],
                [@wp1,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,@wp2,@wp3,@wp4,@wp5,@wp6,@wp7,@wp8],
                [@wr1,@wk1,@wb1,@wKk,@wQq,@wb2,@wk2,@wr2]
            ]
            board_array = board.setBoard(array)
            loc = [1,1]
            dest = [2,1]
            travel = [1,0]
            path = [2,1]

            check = board.checkPath(path, loc, 'pawn')

            expect(check).to eql(0)
        end
        
    
    
    end
   

    context "#checkMove" do

        board = Board.new

        it "returns attack if true for pawn" do
           

        end
    end
end


                