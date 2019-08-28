ActiveAdmin.register Restaurant do
  actions :all, except: [:destroy]

  index do
    column :id
    column :name
    column :address1
    column :image do |resturant|
      image_tag(resturant.image)
    end

    column :original_website do |resturant|
      image_tag(resturant.image)
    end
    actions
  end
end