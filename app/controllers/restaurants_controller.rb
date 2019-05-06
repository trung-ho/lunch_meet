class RestaurantsController < ApplicationController
  def index
    @q = Restaurant.includes(:categories).ransack(params[:q])
    @restaurants = @q.result(distinct: true)
  end
end