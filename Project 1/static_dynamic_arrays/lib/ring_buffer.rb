require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @start_idx = 0
    @length = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(index + @start_idx) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(index + @start_idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    poppedEl = @store[(@start_idx + @length - 1) % @capacity]
    @length -= 1
    poppedEl
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[(@length + @start_idx) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length == 0
    deletedEl = @store[@start_idx]
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    deletedEl
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
  end

  # protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= @length
  end

  def resize!
    @capacity *= 2
    prev_store = @store
    prev_start_idx = @start_idx
    @store = StaticArray.new(@capacity)
    @start_idx = 0
    (@capacity / 2).times do |i|
      @store[i] = prev_store[(prev_start_idx + i) % (@capacity / 2)]
    end
  end
end
