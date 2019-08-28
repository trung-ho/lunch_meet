ActiveAdmin.register Category do
  actions :all, except: [:destroy]

  index do
    column :id
    column :name
    column :alias
    column :restaurant_list do |category|
      if category.restaurants.any?
        category.restaurants.each do |resturant|
          link_to "#{resturant.name}", admin_restaurant_path(resturant.id)
        end
      end
    end
    actions
  end
end