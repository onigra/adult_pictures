require 'instagram'
require 'sequel'
require 'yaml'

YML = YAML.load_file "../config/instagram.yml"
DB = Sequel.connect('sqlite://../db/sinaapp.db')

Instagram.configure do |config|
  config.client_id = YML['info']['client_id'] 
  config.client_secret = YML['info']['client_secret'] 
end

target = DB[:pictures]
update_pictures = Instagram.media_popular

# リンク切れで削除したレコードを取得
deleted_pictures = DB["select * from pictures where deleted_at is not null"].all

update_pictures.each{|item|

  # 削除したレコードが存在すれば、削除したレコードから更新する。
  # 削除したレコードが無ければ、更新日が古いものから更新していく。
  if deleted_pictures.empty? || deleted_pictures.nil?
    target_id = target.order(:updated_at.asc).limit(1).all[0][:id]

    target.where('id = ?', target_id)
          .update(:url => item.images.standard_resolution.url, :updated_at => Time.now)
  else
    target_id = deleted_pictures.shift[:id]

    target.where('id = ?', target_id)
          .update(:url => item.images.standard_resolution.url, :updated_at => Time.now, :deleted_at => nil)
  end

}

