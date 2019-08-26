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

  desc "Search and Scrap Restaurant"
  task :search_and_scrap_cateogry, [:term, :location] => :environment do |t, args|
    url = "https://api.yelp.com/v3/businesses/search"
    api_key = ENV['YELP_API_KEY']
    params = {
      term: args.term,
      location: args.location
    }

    response = HTTP.auth("Bearer #{api_key}").get("#{url}", params: params)
    result = response.parse
    result['businesses'].each do |r|
      restaurant = Restaurant.find_or_create_by(
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
        provider: 'yelp',
        resource_id: r['id']
      )
      categories = r['categories']
      if categories.any?
        categories.each do |category|
          result = Category.find_or_create_by(alias: category['alias'], name: category['title'])
          restaurant.restaurant_categories.create(category: result)
        end
      end
    end
  end
end

