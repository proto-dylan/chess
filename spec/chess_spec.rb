
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
        puts "array: #{array[0][0]}"
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
    context '#checkMove' do 
    subject(:board) {Board.new} 
        it "returns true if valid pawn move" do
            array=board.setBoard
            piece = array[1][1]
            puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [2,1])
            expect(val).to be true
        end
        it "returns false if the pawn move is invalid" do
            array=board.setBoard
            piece = array[1][1]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [2,2])
            expect(val).to be false
        end
        it "returns false if Kinght move is invalid" do
            array=board.setBoard
            piece = array[0][1]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [2,4])
            expect(val).to be false
        end
        it "returns true if Kinght move is valid" do
            array=board.setBoard
            piece = array[0][1]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [2,2])
            expect(val).to be true
        end
        it "returns true for bishop move" do
            array=board.setBoard
            piece = array[0][2]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [2,4])
            expect(val).to be true
        end
        it "returns false for bishop move" do
            array=board.setBoard
            piece = array[0][2]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [1,4])
            expect(val).to be false
        end
        it "returns true for rook move" do
            array=board.setBoard
            piece = array[0][0]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [0,4])
            expect(val).to be true
        end
        it "returns false for rook move" do
            array=board.setBoard
            piece = array[0][0]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [1,4])
            expect(val).to be false
        end
        it "returns true for queen move" do
            puts "QHEEEEEENN"
            array=board.setBoard
            piece = array[0][3]
           # puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [4,3])
            expect(val).to be true
        end
        it "returns false for queen move" do
            puts "QHEEEEEENN"
            array=board.setBoard
            piece = array[0][3]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [8,3])
            expect(val).to be false
        end
        it "returns true for queen move" do
            puts "QHEEEEEENN"
            array=board.setBoard
            piece = array[0][3]
            #puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [1,0])
            expect(val).to be false
        end
        it "returns false for king" do
            array=board.setBoard
            piece = array[0][4]
            puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [1,4])
            expect(val).to be true
        end
        it "returns true for king" do
            array=board.setBoard
            piece = array[0][4]
            puts "piece  #{piece}, #{piece.type}, #{piece.init}, #{piece.moves}"
            val = board.checkMove(piece, [1,0])
            expect(val).to be false

        end
    end 
    context "#buildPathTree" do
    subject(:board) {Board.new} 
        it "returns an array do" do
            array=board.setBoard

            piece = array[6][1]

            move = [4,1]
            #piece = double('piece')
           # move = double('move')

            #allow(piece).to receive(:piece) { array[1][1] }
            #allow(move).to receive(:move) { [1,3] }
            
            path = board.buildPathTree(piece, move)
            expect(path).to be_instance_of(Array)

        end
    end
end


                