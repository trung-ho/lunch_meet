require "dry/transaction"

class FindBestRestaurants
  include Dry::Transaction

  step :find_nearest_restaurants
  step :find_best_match_restaurant

  private

  def find_nearest_restaurants(event:, **other)
    if event.to_coordinates.any? && event.radius
      restaurants = Restaurant.near(event.to_coordinates, event.radius)
      Success(event: event, restaurants: restaurants)
    else
      Failure('Fail to find restaurants')
    end
  end

  def find_best_match_restaurant(input)
    users = event.group.members
    Success(event: event)
  end
end
