require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1
    # @store[@length] = nil
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    prev_store = @store
    @store = StaticArray.new(@capacity)
    @length.times do |i|
      next if i == 0
      @store[i - 1] = prev_store[i]
    end
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    prev_store = @store
    @store = StaticArray.new(@capacity)
    @store[0] = val
    @length.times do |i|
      @store[i + 1] = prev_store[i]
    end
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length


  def check_index(index)
    raise 'index out of bounds' if index >= @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    prev_store = @store
    @store = StaticArray.new(@capacity)
    (@capacity / 2).times { |i| @store[i] = prev_store[i] }
  end
end
