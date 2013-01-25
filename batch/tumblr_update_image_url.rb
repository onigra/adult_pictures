require 'sequel'
require_relative '../lib/api_connect.rb'

instance = ApiClient.new("../config/config.yml")
client = instance.tumblr_init

update_pictures = Array.new

(0..1).each do |i|
  user_posts = client.likes(i, 20)

  user_posts['liked_posts'].map {|item|
    update_pictures << item['photos'].map {|photo| photo['original_size']['url']}
  }
  # ちょっと待たないとエラーになる
  sleep(1)
end

DB = Sequel.connect('sqlite://../db/sinaapp.db')
target = DB[:adult_pictures]

# リンク切れで削除したレコードを取得
deleted_pictures = DB["select * from adult_pictures where deleted_at is not null"].all

update_pictures.each {|item|
  # ---------------------------------------------------------------
  # 削除したレコードが存在すれば、削除したレコードから更新する。
  # 削除したレコードが無ければ、更新日が古いものから更新していく。
  # ---------------------------------------------------------------
  if deleted_pictures.empty? || deleted_pictures.nil?
    target_id = target.order(:updated_at.asc).limit(1).all[0][:id]

    target.where('id = ?', target_id)
          .update(:url => item, :updated_at => Time.now)
  else
    target_id = deleted_pictures.shift[:id]

    target.where('id = ?', target_id)
          .update(:url => item, :updated_at => Time.now, :deleted_at => nil)
  end

}

