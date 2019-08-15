class RestaurantsController < ApplicationController
  def index
    authorize self, :edit?
    @q = Restaurant.includes(:categories).ransack(params[:q])
    @restaurants = @q.result(distinct: true).order(created_at: :desc)
  end
end