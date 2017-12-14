class RestaurantsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    if user_signed_in?
      render json: { restaurants: Restaurant.all}
    else
      redirect_to ("/users/sign_in")
    end
  end

  def show
    render file: Rails.public_path.join("templates","one_restaurant.html"), layout: true
  end

  def create
      new_player = Player.new(player_params)
      if new_player.save
        render json: { player: new_player }
      else
        render json: { errors: new_player.errors }, status: 500
      end
    end

  def create
    restaurant = Restaurant.create(name: params[:name], description: params[:description], user_id: current_user.id)
    imagge = Image.create(source: params[:image], restaurant_id: restaurant.id)
    redirect_to ("/restaurants")
  end
end
