require 'sinatra'
require 'erb'
require 'sequel'
require_relative 'lib/methods'

enable :sessions
set :public_folder, File.dirname(__FILE__) + '/static'

DB = Sequel.connect('sqlite://db/sinaapp.db')

pic = Array.new
select_num_list = create_uniq_num_list

select_num_list.each {|key|
  DB[:pictures].filter(:id => key).map {|item|
    pic << item[:url]
  }
}

get "/" do
  @pictures = Array.new

  pic.each {|item|
    @pictures << "<a href='#{item}' rel='lightbox'><img src='#{item}'></img></a>"
  }
  
  erb :index
end
