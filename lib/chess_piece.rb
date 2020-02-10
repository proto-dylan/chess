
class Piece
    attr_accessor :type, :init, :uni, :color, :moves, :location, :move_counter, :travel, :attacking 
    def initialize(
        type:,
        uni:,
        color:,
        moves: [],
        location: [],
        travel: [],
        move_counter:,
        attacking: []
    )
    @type = type
    @init = type[0]
    @uni = uni
    @color = color
    @moves = moves
    @location = location
    end
end