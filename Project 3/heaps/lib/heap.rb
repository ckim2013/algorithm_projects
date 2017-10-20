require 'byebug'
class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc || Proc.new { |v1, v2| v1 <=> v2 }
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    popped_el = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    popped_el
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    children = []
    left_child = 2 * parent_index + 1
    right_child = 2 * parent_index + 2
    children.push(left_child) if left_child < len
    children.push(right_child) if right_child < len
    children
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index < 1
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    children_indices = BinaryMinHeap.child_indices(len, parent_idx)
    return array if children_indices.empty?

    l_child_idx, r_child_idx = children_indices
    l_child_val = array[l_child_idx]
    r_child_val = array[r_child_idx] if r_child_idx
    parent_val = array[parent_idx]

    swapped_child_idx = l_child_idx

    if r_child_idx && prc.call(l_child_val, r_child_val) == 1
      swapped_child_idx = r_child_idx
    end

    swapped_child_val = array[swapped_child_idx]

    if prc.call(parent_val, swapped_child_val) == 1
      new_array = BinaryMinHeap.switch(array, parent_idx, swapped_child_idx)
      parent_idx = swapped_child_idx
      return BinaryMinHeap.heapify_down(new_array, parent_idx, &prc)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if child_idx == 0
    parent_idx = BinaryMinHeap.parent_index(child_idx)


    parent_val = array[parent_idx]
    child_val = array[child_idx]

    if prc.call(parent_val, child_val) == 1
      new_array = BinaryMinHeap.switch(array, parent_idx, child_idx)
      child_idx = parent_idx
      return BinaryMinHeap.heapify_up(array, child_idx, &prc)
    end

    array

  end

  def self.switch(array, node_1, node_2)
    array[node_1], array[node_2] = array[node_2], array[node_1]
    array
  end
end
