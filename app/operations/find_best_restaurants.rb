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

  def find_best_match_restaurant(event:, restaurants:, **other)
    all_members = event.group.all_members
    user_preferences_hash = Hash.new{}
    all_preferences_id= []
    all_members.each do |member|
      member_preferences_id = UserCategory.where(user_id: member.id).pluck(:category_id)
      user_preferences_hash[member.id] = member_preferences_id
      all_preferences_id += member_preferences_id
    end
    all_preferences_id.uniq!

    matched_restaurant_categories = RestaurantCategory.where(category_id: all_preferences_id, restaurant_id: restaurants.reorder('').pluck(:id)) 
    matched_restaurant_categories_hash = Hash.new{}
    matched_restaurant_categories.each do |restaurant_category|
      matched_restaurant_categories_hash[restaurant_category.restaurant_id] ||= []
      matched_restaurant_categories_hash[restaurant_category.restaurant_id] << restaurant_category.category_id
    end

    relevant_hash = Hash.new{}
    matched_restaurant_categories_hash.each do |restaurant_id, category_ids|
      relevant_hash[restaurant_id] ||= []
      user_preferences_hash.each do |user_id, preference_ids|
        if (category_ids - preference_ids) != category_ids
          relevant_hash[restaurant_id] << user_id
        end
      end
    end

    top_10_relevant = relevant_hash.sort_by {|_key, value| value.size}.reverse.first(10).to_h
    top_10_restaurants = restaurants.where(id: top_10_relevant.keys)
    top_10_restaurants.each do |top_restaurant|
      event_restaurant = top_restaurant.event_restaurants.new event: event, 
                                                              distance: top_restaurant.distance, 
                                                              match: top_10_relevant[top_restaurant.id]
      event_restaurant.save
    end
    if event.in_active?
      event.reviewing!
    end
    Success(event: event)
  end
end
