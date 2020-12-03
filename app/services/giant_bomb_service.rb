class GiantBombService
    def initialize
        @search = GiantBomb::Search.new
    end

    def game_search(name)
        @search.offset(3)
        @search.limit(10) # max 100
        @search.resources('game')
        @search.fields('name')
        @search.query(name)
        return @search.fetch
    end
end
