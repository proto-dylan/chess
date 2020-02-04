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
    end
end
                