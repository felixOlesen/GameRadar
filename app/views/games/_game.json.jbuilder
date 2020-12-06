json.extract! game, :id, :name, :deck, :og_release_date, :expected_release_day, :expected_release_month, :expected_release_year, :platforms, :image, :gb_id, :created_at, :updated_at
json.url game_url(game, format: :json)
