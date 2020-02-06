
class Piece
    attr_accessor :type, :init, :uni, :color, :moves, :location, :moved
    def initialize(
        type:,
        uni:,
        color:,
        moves: [],
        location: [],
        moved: false
    )
    @type = type
    @init = type[0]
    @uni = uni
    @color = color
    @moves = moves
    @location = location
    end
end