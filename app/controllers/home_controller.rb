class HomeController < ApplicationController
before_action :authenticate_user!, only:[:gb_search]
  def home
  end

  def contact
  end

  #Sends flash notices in case no email is inputted in form
  def request_contact
    name = params[:name]
    email = params[:email]
    message = params[:message]
    if email.blank?
        flash[:alert] = I18n.t('home.request_contact.no_email')
    else
        ContactMailer.contact_email(email, name, message).deliver_now
        flash[:notice] = I18n.t('home.request_contact.email_sent')
    end
  redirect_to root_path
  end

  #main search method called by search form in home page
  def gb_search
      #if the search input is not blank, continue on with search
      if params[:search_games] != ""
          #calls search games method in giant bomb servie file
          #returns array of game IDs from giant bomb api
          @id_arr = giantbomb_service.game_search(params[:search_games])
          #loops through array of IDs and adds them to db if they don't already exist
          @id_arr.each do |element|
              single_id = element.values_at("id")[0]
              if Game.where(:gb_id => single_id).blank?
                  add_giantbomb_games(single_id)
              end
          end
      else
          #if search is blank redirect to games index
          redirect_to games_path
      end
  end

  private
    #sets singleton class of giantbomb service class
    def giantbomb_service
        @gb_service ||= GiantBombService.new
    end

    #called by gb_search if new games are found in the search results
    def add_giantbomb_games(seed_id)
        game_test = Game.where(gb_id: seed_id).first
        game_test.delete if game_test

        #initialises all variables from fields returned by query to giant bomb api
        t_game = GiantBomb::Game.detail(seed_id)
        g_name = t_game.name
        g_deck = t_game.deck
        og_date_gb = t_game.original_release_date
        day_gb = t_game.expected_release_day
        year_gb = t_game.expected_release_year
        month_gb = t_game.expected_release_month
        g_platforms = ""
        g_image = t_game.image.values_at("small_url")
        g_image = g_image[0]
        g_id = t_game.id

        if t_game.platforms != nil
            t_game.platforms.each_with_index do |item, index|
                g_platforms += item.values_at("name")[0]
                if index != t_game.platforms.length()-1
                    g_platforms += " / "
                end
            end
        end
        #creates game in Game table using new initialised variables
        games = Game.create([name: g_name, deck: g_deck, image: g_image, og_release_date: og_date_gb, expected_release_day: day_gb, expected_release_month: month_gb, expected_release_year: year_gb, platforms: g_platforms, gb_id: g_id])
    end


end
