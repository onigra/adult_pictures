require 'instagram'
require 'sequel'
require 'yaml'

YML = YAML.load_file "../config/instagram.yml"
DB = Sequel.connect('sqlite://../db/sinaapp.db')

Instagram.configure do |config|
  config.client_id = YML['info']['client_id'] 
  config.client_secret = YML['info']['client_secret'] 
end

pics = Instagram.media_popular

pics.each{|item|
  target_id = DB[:pictures].order(:updated_at.asc).limit(1).all[0][:id]
  
  DB[:pictures].where('id = ?', target_id)
               .update(:url => item.images.standard_resolution.url, :updated_at => Time.now)
}
