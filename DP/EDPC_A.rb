# 問題
# https://atcoder.jp/contests/dp/tasks/dp_a
#
# 解法
# https://qiita.com/drken/items/dc53c683d6de8aeacf5a

n = 7
h = [2, 9, 4, 5, 1, 6, 10]
costs = Array.new(n, 0)

h.length.times do |i|
  if i == 0
    next
  end
  if i == 1
    costs[i] = (h[i] - h[i - 1]).abs
    next
  end
  cost1 = (h[i] - h[i - 1]).abs
  cost2 = (h[i] - h[i - 2]).abs
  costs[i] = cost1 < cost2 ? cost1 + costs[i - 1] : cost2 + costs[i - 2]
end

p costs
puts costs[h.length - 1]