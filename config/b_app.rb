require 'rubygems'
require 'sinatra'
require 'erb'
require 'sequel'
require 'mysql2'

enable :sessions
set :public_folder, File.dirname(__FILE__) + '/static'

DB = Sequel.connect('mysql2://root:naruhaya@localhost/sinaapp')
pic = DB[:pictures].order(Sequel.desc(:id)).limit(50)

get "/" do
  @pictures = Array.new

  pic.map{|item|
     @pictures << "<a href='#{item[:url]}' rel='lightbox'><img src='#{item[:url]}'></img></a>"
  }
  
  erb :index
end
