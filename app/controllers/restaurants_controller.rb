class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all.includes(:categories)
  end
end