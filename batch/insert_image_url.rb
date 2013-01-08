require 'instagram'
require 'sequel'

DB = Sequel.connect('sqlite://../db/sinaapp.db')
pic = DB[:pictures]

Instagram.configure do |config|
  config.client_id = "2d6c74c7d3ef427b90c9806eff8dc33e"
  config.client_secret = "b67ecb7c3d154c47907e03ae2f862976"
end

client = Instagram.media_popular
client.map{|item|
  pic.insert(:url => "#{item.images.standard_resolution.url}", :created_at => Time.now, :updated_at => Time.now)
}

