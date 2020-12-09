class GiantBombService
    def initialize
        @search = GiantBomb::Search.new
    end

    def game_search(name)
        @search.offset(3)
        @search.limit(15) # max 100
        @search.resources('game')
        @search.fields('id')
        @search.query(name)
        return @search.fetch
    end
end
