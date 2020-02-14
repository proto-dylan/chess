
class Piece
    attr_accessor :type, :init, :uni, :color, :moves, :location, :move_counter, :travel, :attacking, :last_turn 
    def initialize(
        type:,
        uni:,
        color:,
        moves: [],
        location: [],
        travel: [],
        move_counter:,
        attacking: [],
        last_turn:
    )
    @type = type
    @init = type[0]
    @uni = uni
    @color = color
    @moves = moves
    @location = location
    @move_counter = move_counter
    @attacking = attacking
    @last_turn = last_turn
    end
end