require './lib/chess.rb'

describe Chess do
    

    describe Board do

        describe '#setBoard' do

            game = Chess.new

            it "makes knights" do
                expect(@bk1.init).to eql('k')
            end
        end
    end
                
end   