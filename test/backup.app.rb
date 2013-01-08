require 'sinatra'
require 'instagram'
require 'erb'
require 'yaml'

YML = YAML.load_file "./config/instagram.yml"

enable :sessions
set :public_folder, File.dirname(__FILE__) + '/static'

Instagram.configure do |config|
  config.client_id = YML['info']['client_id'] 
  config.client_secret = YML['info']['client_secret'] 
end

get "/" do
  @pictures = Array.new

  client1 = Instagram.media_popular
  client2 = Instagram.media_popular
  client3 = Instagram.media_popular
  client1.map{|item|
     @pictures << "<a href='#{item.images.standard_resolution.url}' rel='lightbox'><img src='#{item.images.standard_resolution.url}'></img></a>"
  }
  client2.map{|item|
     @pictures << "<a href='#{item.images.standard_resolution.url}' rel='lightbox'><img src='#{item.images.standard_resolution.url}'></img></a>"
  }
  client3.map{|item|
     @pictures << "<a href='#{item.images.standard_resolution.url}' rel='lightbox'><img src='#{item.images.standard_resolution.url}'></img></a>"
  }
  
  erb :index
end
