require_relative '../lib/api_connect.rb'

instance = ApiClient.new("../config/config.yml")
client = instance.instagram_init

pictures = client.media_popular
pictures.map {|item|
  puts item.images.standard_resolution.url
}

