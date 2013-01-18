# coding: utf-8

class Utils

  # -------------------------------------------------
  #  1から500までの数値の中で、50個のユニークな数値を
  #  ランダムで選択して配列にして返すメソッド
  # -------------------------------------------------
  def self.create_uniq_num_list
    uniq_nums = Array.new

    (0..47).each {|i|
      nums_list = (1..500).to_a

      uniq_nums << nums_list.sample
      nums_list.reject! {|x| x == uniq_nums[i] }
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

