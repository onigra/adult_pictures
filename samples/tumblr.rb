require_relative '../lib/api_connect.rb'

instance = ApiClient.new("../config/config.yml")
client = instance.tumblr_init

(0..5).each do |num|
  user_posts = client.likes(num, 10)
  
  user_posts['liked_posts'].map {|item|
    puts item['photos'].map {|photo| photo['original_size']['url']}
  } 

  # ちょっと待たないとエラーになる
  sleep(1)
end

