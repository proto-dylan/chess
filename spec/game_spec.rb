
require 'spec_helper'
require 'stringio'
require './lib/chess_piece.rb' 
require './lib/chess.rb'
require './lib/chess_board.rb'

describe "Game" do
    game = Game.new

    it "does stuff" do

        
        puts "HERE"
        io = StringIO.new
        io.puts "a7 to a5"
        io.puts "b2 to b4"
        io.puts "a5 to b4"
        io.rewind
        
        $stdin = io
    end

            
end