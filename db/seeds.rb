# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

game_test = Game.where(gb_id: 6539).first
game_test.delete if game_test


t_game = GiantBomb::Game.detail(6539)
g_name = t_game.name
g_deck = t_game.deck
og_date_gb = t_game.original_release_date
day_gb = t_game.expected_release_day
year_gb = t_game.expected_release_year
month_gb = t_game.expected_release_month
g_platforms = ""
g_image = t_game.image.values_at("medium_url")
g_id = t_game.id


t_game.platforms.each_with_index do |item, index|
    g_platforms += item.values_at("name")[0] + " "
end

games = Game.create([name: g_name, deck: g_deck, image: g_image, og_release_date: og_date_gb, expected_release_day: day_gb, expected_release_month: month_gb, expected_release_year: year_gb, platforms: g_platforms, gb_id: g_id])
