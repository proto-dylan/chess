require './lib/chess.rb'

   
describe Board do 
    let(:board) {Board.new}     
    
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
            expect(array[1][0].moves).to eql([[0,1],[0,2]])
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
end
                
