require 'sinatra'
require 'erb'
require 'sequel'
require_relative 'lib/methods'

enable :sessions
set :public_folder, File.dirname(__FILE__) + '/static'
 
DB = Sequel.connect('sqlite://db/sinaapp.db')

get "/" do
  @pictures = Array.new
  select_num_list = create_uniq_num_list
  
  select_num_list.each {|key|
    DB[:pictures].filter(:id => key).map {|item|
      @pictures << "<div class='item'><img src='#{item[:url]}'></img></div>"
    }
  }

  erb :index
end

