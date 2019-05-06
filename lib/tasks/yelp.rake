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
end

