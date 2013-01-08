require 'sinatra'
require 'erb'
require 'sequel'

enable :sessions
set :public_folder, File.dirname(__FILE__) + '/static'

DB = Sequel.connect('sqlite://db/sinaapp.db')

pic = Array.new
50.times {
  DB[:pictures].filter(:id => (1..32).to_a.sample).map{|item|
    pic << item[:url]
  }
}

get "/" do
  @pictures = Array.new

  pic.each{|item|
    @pictures << "<a href='#{item}' rel='lightbox'><img src='#{item}'></img></a>"
  }
  
  erb :index
end
