# coding: utf-8

class Utils

  # -------------------------------------------------
  #  1から500までの数値の中で、50個のユニークな数値を
  #  ランダムで選択して配列にして返すメソッド
  #  nums_list = Array
  # -------------------------------------------------
  def self.create_uniq_num_list(nums_list)
    uniq_nums = Array.new
    
    (0..47).each {|i|
      uniq_nums << nums_list.sample
      nums_list.reject! {|x| x == uniq_nums[i] }
    }
  
    return uniq_nums
  end
  
  def self.random_size
    list = [
      196,
      96,
    ]
    
    return list
  end
end

