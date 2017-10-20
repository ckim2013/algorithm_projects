require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2

    pivot = array[0]

    left = []
    right = []

    array[1..-1].each do |el|
      if el < pivot
        left.push(el)
      else
        right.push(el)
      end
    end

    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length - start <= 1
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot_idx, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, length, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    pivot = array[start]
    barrier_idx = start

    array[start + 1...length + start].each.with_index do |el, i|
      if prc.call(pivot, el) == 1
        array[i + 1 + start], array[barrier_idx + 1] = array[barrier_idx + 1], array[i + 1 + start]
        barrier_idx += 1
      end
    end

    array[start], array[barrier_idx] = array[barrier_idx], array[start]

    barrier_idx
  end
end
