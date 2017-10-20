require_relative "heap"

class Array
  def heap_sort!
    heapify = BinaryMinHeap.new

    self.each do |el|
      heapify.push(el)
    end

    heapify.count.times do |i|
      self[i] = heapify.extract
    end
    self
  end
end
