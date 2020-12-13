class GiantBombService
    #Sets up a new instance of giant bomb api gem
    def initialize
        @search = GiantBomb::Search.new
    end

    #game search method called by home controller for gb_search
    def game_search(name)
        @search.offset(3)
        @search.limit(15) # max 100
        @search.resources('game')
        @search.fields('id')
        @search.query(name)
        return @search.fetch
    end
end
