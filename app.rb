require 'sinatra'
require 'erb'
require 'sequel'
require_relative 'lib/util'

enable :sessions
set :public_folder, File.dirname(__FILE__) + '/static'
 
DB = Sequel.connect('sqlite://db/sinaapp.db')

get "/" do
  @pictures = Array.new
  select_num_list = Utils.create_uniq_num_list((1..514).to_a)
  foo = Utils.random_size
  
  select_num_list.each {|key|
    size = foo.sample
    DB[:pictures].filter(:id => key).map {|item|
      @pictures << "<div class='item'><img src='#{item[:url]}' width=196 height=#{size} ></img></div>"
    }
  }

  erb :index
end

