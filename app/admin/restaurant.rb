ActiveAdmin.register Restaurant do
  actions :all, except: [:destroy]
  filter :name_cont, as: :string, label: "Name"
  filter :rating
  filter :categories

  index do
    column :id
    column :name
    column :display_address
    column :image do |resturant|
      image_tag(resturant.image)
    end

    column :original_website do |resturant|
      if resturant.url.present?
        link_to "View resturant in Yelp", resturant.url
      else
        'Cannot find provider'
      end
    end

    actions
  end
end