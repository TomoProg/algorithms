# 問題
# https://paiza.jp/works/mondai/dp_primer/dp_primer_stairs_boss/edit?language_uid=ruby

# 入力値取得
n, a, b, c = gets.split(' ').map(&:to_i)

# 第1フェーズの階段の登り方の数を計算する
# key： 階段の段数
# value： keyの段数までの登り方の数
# 最後に合計した際にキーがないとエラーになってしまうため、nも設定しておく
ways_count_per_phase = [{n => 0, a => 1, b => 1, c => 1}]

# 第2フェーズ以降の階段の登り方の数を計算する
# 前回フェーズの段数と登ることができる段数を足し合わせれば、何段目にいけるのかが分かる
loop do
  before_phase = ways_count_per_phase.last
  result = Hash.new(0)
  before_phase.keys.each do |current_stair|
    [a, b, c].each do |up_stairs|
      # 登り方は1つではなく、前回フェーズの登り方の数だけ存在するため注意
      #
      # 例： a=2, b=3 の場合に 5段目から7段目に行く方法の数
      #    5段目から7段目に行く場合、2登るしかないため、方法は一つと思いがちだが、
      #    5段目に行く方法は (2, 3)、(3, 2)の2つが存在するため、
      #    7段目に登る方法は (2, 3, 2)、(3, 2, 2) の2つ存在する
      result[current_stair + up_stairs] += before_phase[current_stair]
    end
  end

  #puts ways_count_per_phase
  #puts ""

  # 今回のフェーズで一番小さい階段の段数が指定された段数より大きい場合、
  # 次のフェーズ以降はすべて指定された段数よりも大きい段に登ってしまうためループを抜ける
  break if result.keys.min > n
  ways_count_per_phase << result
end

# フェーズごとの指定された段数の登り方の数を合計したものが答えになる
puts ways_count_per_phase.sum { |phase| phase[n] }