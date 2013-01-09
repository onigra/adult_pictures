# coding: utf-8

# 1から500までの数値の中で、50個のユニークな数値を
# ランダムで選択して配列にして返すメソッド
def create_uniq_num_list
  uniq_nums = Array.new
  nums_list = (1..160).to_a
  
  (0..49).each {|i|
    uniq_nums << nums_list.sample
    nums_list.reject! {|x| x == uniq_nums[i] }
  }

  return uniq_nums
end

