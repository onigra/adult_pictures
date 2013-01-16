require 'instagram'
require 'sequel'
require 'yaml'

YML = YAML.load_file "../config/instagram.yml"
DB = Sequel.connect('sqlite://../db/sinaapp.db')

Instagram.configure do |config|
  config.client_id = YML['info']['client_id'] 
  config.client_secret = YML['info']['client_secret'] 
end

target = DB[:pictures]
insert_pictures = Instagram.media_popular

insert_pictures.each{|item|
  target.insert(:url => item.images.standard_resolution.url, :created_at => Time.now, :updated_at => Time.now)
}

