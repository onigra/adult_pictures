require 'sequel'

DB = Sequel.connect('sqlite://../db/sinaapp.db')

pic = Array.new
50.times {
  DB[:pictures].filter(:id => (1..15).to_a.sample).map{|item|
    pic << item[:url]
  }
}

puts pic
