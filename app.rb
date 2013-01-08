require 'sinatra'
require 'erb'
require 'sequel'

enable :sessions
set :public_folder, File.dirname(__FILE__) + '/static'

DB = Sequel.connect('sqlite://sinaapp.db')

pic = Array.new
50.times {
  pic << DB[:pictures].filter(:name => (1..15).to_a.sample)
}

get "/" do
  @pictures = Array.new

  pic.map{|item|
     @pictures << "<a href='#{item[:url]}' rel='lightbox'><img src='#{item[:url]}'></img></a>"
  }
  
  erb :index
end
