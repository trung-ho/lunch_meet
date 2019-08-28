namespace :yelp do
  desc "Scraping Category"
  task :scraping_cateogry => :environment do |t, args|
    url = "https://api.yelp.com/v3/categories"
    api_key = ENV['YELP_API_KEY']

    response = HTTP.auth("Bearer #{api_key}").get("#{url}")
    result = response.parse
    result['categories'].each do |category|
      next if category['parent_aliases'] && !(category['parent_aliases'].include? 'restaurants')
      next if (category['country_blacklist'] && category['country_blacklist'].any?) || 
              (category['country_whitelist'] && category['country_whitelist'].any?)
      Category.find_or_create_by(alias: category['alias'], name: category['title'])
    end
  end

  desc "Search and Scrap Restaurant by Category"
  task :search_and_scrap_restaurant_by_cateogry, [:term, :location] => :environment do |t, args|
    url = "https://api.yelp.com/v3/businesses/search"
    api_key = ENV['YELP_API_KEY']
    
    Category.all.each do |category|
      puts "Begin finding restaurant for category: #{category.name}"
      params = {
        categories: category.alias,
        location: 'SD',
        limit: 50
      }
      total_restaurant = 0
      (0..4).each do |val|
        offset = val*50
        params_with_offset = params.merge(offset: offset)
        response = HTTP.auth("Bearer #{api_key}").get("#{url}", params: params_with_offset)
        result = response.parse
        begin
          result['businesses'].each do |r|
            restaurant = Restaurant.find_or_create_by(
              provider: 'yelp',
              provider_id: r['id'],
              alias: r['alias'], 
              name: r['name'],
              image: r['image_url'],
              url: r['url'],
              rating: r['rating'],
              price: r['price'],
              address1: r['location']['address1'],
              address2: r['location']['address2'],
              address3: r['location']['address3'],
              city: r['location']['city'],
              zip_code: r['location']['zip_code'],
              country: r['location']['country'],
              state: r['location']['state'],
              display_address: r['location']['display_address'],
              phone: r['phone'],
              display_phone: r['display_phone'],
              latitude: r['coordinates']['latitude'],
              longitude: r['coordinates']['longitude']
            )
            categories_json = r['categories']
            if categories_json.any?
              categories_json.each do |json|
                cat = Category.where(alias: json['alias']).last
                RestaurantCategory.find_or_create_by(restaurant: restaurant, category: cat)
              end
            end
          end
        rescue Exception => e
          puts "Caught exception #{e}!"
          puts "Restaurant id: #{r['id']}"
        end
        total_restaurant = result['total']
        break if result['total'] < (offset + 50)
      end
      puts "Found total #{total_restaurant} restaurants"
      puts "Finish finding restaurant for category: #{category.name}"
    end
  end
end

