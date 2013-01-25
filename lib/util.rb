require 'sequel'

class Utils

  # ---------------------------------------------------
  #  削除されてないidの中から、47個のユニークな数値を
  #  ランダムで選択して配列にして返すメソッド。
  #  47個なのはcontainerのサイズ的にちょうどいいから。
  # ---------------------------------------------------
  def self.create_uniq_num_list
    db = Sequel.connect('sqlite://db/sinaapp.db')
    deleted_list = db["select * from adult_pictures where deleted_at is null"].all

    num_list = Array.new
    deleted_list.each {|item|
      num_list << item[:id]
    }

    uniq_nums = Array.new
    (0..47).each {|i|
      uniq_nums << num_list.sample
      num_list.reject! {|x| x == uniq_nums[i]}
    }
  
    return uniq_nums
  end
  
  def self.create_picture_height
    size_list = [
      196,
      96,
      86,
      226,
      156
    ]
    
    return size_list
  end
end

