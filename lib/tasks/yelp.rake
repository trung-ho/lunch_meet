namespace :yelp do
  desc "Scraping Category"
  task :scraping_cateogry, [:provider] => :environment do |t, args|
    if args.provider == 'yelp'
      url = "https://api.yelp.com/v3/categories"
      api_key = ENV['YELP_API_KEY']
    end

    response = HTTP.auth("Bearer #{api_key}").get("#{url}")
    result = response.parse
    result['categories'].each do |category|
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
        name: r['title'],
        image: r['image'],
        url: r['url'],
        rating: r['rating'],
        price: r['price'],
        address1: r['address1'],
        address2: r['address2'],
        address3: r['address3'],
        city: r['city'],
        zip_code: r['zip_code'],
        country: r['country'],
        state: r['state'],
        display_address: r['display_address'],
        phone: r['phone'],
        display_phone: r['display_phone'],
        provider: r['provider'],
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

