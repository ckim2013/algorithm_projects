require_relative 'heap'

def k_largest_elements(array, k)
  sorted_array = []
  heap = BinaryMinHeap.new
  array.each do |el|
    heap.push(el)
  end

  until heap.count == 0
    sorted_array << heap.extract
  end

  sorted_array.drop(sorted_array.count - k)
end
