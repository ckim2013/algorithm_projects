require 'byebug'
class DynamicProgramming

  def initialize
    @blair_cache = {
      1 => 1,
      2 => 2
    }

    @frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }

    @super_frog_cache = {
      0 => [[]],
      1 => [[1]]
    }
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    @blair_cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + (2 * n - 3)
    @blair_cache[n]
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    frog_cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1,], [1, 2], [2, 1], [3]]
    }

    return frog_cache if n < 4

    (4..n).each do |i|
      arr1 = frog_cache[i - 1].map { |arr| [1] + arr }
      arr2 = frog_cache[i - 2].map { |arr| [2] + arr }
      arr3 = frog_cache[i - 3].map { |arr| [3] + arr }
      frog_cache[i] = arr1 + arr2 + arr3
    end

    frog_cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    arr1 = frog_hops_top_down_helper(n - 1).map { |arr| [1] + arr }
    arr2 = frog_hops_top_down_helper(n - 2).map { |arr| [2] + arr }
    arr3 = frog_hops_top_down_helper(n - 3).map { |arr| [3] + arr }
    @frog_cache[n] = arr1 + arr2 + arr3
    @frog_cache[n]
  end

  # (n, k)
  def super_frog_hops(num_stairs, max_stairs)
    super_frog_helper(num_stairs, max_stairs)
  end

  def super_frog_helper(num_stairs, max_stairs)
    return @super_frog_cache[num_stairs] if num_stairs < 2

    res = []

    if num_stairs < max_stairs
      (1..num_stairs).each do |i|
        next if (i == num_stairs && num_stairs > max_stairs)
        res += super_frog_helper(num_stairs - i, max_stairs).map { |arr| [i] + arr }
      end
    else
      (1..max_stairs).each do |i|
        res += super_frog_helper(num_stairs - i, max_stairs).map { |arr| [i] + arr }
      end
    end

    @super_frog_cache[num_stairs] = res
    @super_frog_cache[num_stairs]
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
