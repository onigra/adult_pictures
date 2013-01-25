require 'sequel'
require_relative '../lib/api_connect.rb'

DB = Sequel.connect('sqlite://../db/sinaapp.db')
target = DB[:pictures]

instance = ApiClient.new("../config/config.yml")
client = instance.instagram_init

insert_pictures = client.media_popular
insert_pictures.map {|item|
  target.insert(:url => item.images.standard_resolution.url, :created_at => Time.now, :updated_at => Time.now)
}

