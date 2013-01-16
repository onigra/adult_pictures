require 'instagram'
require 'sequel'
require 'yaml'

YML = YAML.load_file "../config/instagram.yml"

Instagram.configure do |config|
  config.client_id = YML['info']['client_id'] 
  config.client_secret = YML['info']['client_secret'] 
end

DB = Sequel.connect('sqlite://../db/sinaapp.db')
pic = DB[:pictures]

client = Instagram.media_popular
client.map{|item|
  pic.insert(:url => "#{item.images.standard_resolution.url}", :created_at => Time.now, :updated_at => Time.now)
}

