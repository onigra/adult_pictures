require 'sinatra'
require 'erb'
require 'sequel'
require_relative 'lib/util'

enable :sessions
set :public_folder, File.dirname(__FILE__) + '/static'
 
DB = Sequel.connect('sqlite://db/sinaapp.db')

get "/" do
  @pictures = Array.new
  select_num_list = Utils.create_uniq_num_list((1..304).to_a)
  
  select_num_list.each {|key|
    DB[:pictures].filter(:id => key).map {|item|
      @pictures << "<div class='grid3'><img src='#{item[:url]}' width='138' height='138'></img></div>"
    }
  }

  erb :index
end

