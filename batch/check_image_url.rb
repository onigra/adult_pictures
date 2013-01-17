require 'httparty'
require 'sequel'

DB = Sequel.connect('sqlite://../db/sinaapp.db')
target = DB[:pictures]

# httpステータスが200が返ってこないレコードを論理削除する
target.select_all.each{|item|
  target_id = item[:id]

  response = HTTParty.get(item[:url])
  if response.code != 200
    target.where('id = ?', target_id).update(:deleted_at => Time.now)
  end
}

