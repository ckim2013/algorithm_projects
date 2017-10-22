require_relative 'bst_node'
require 'byebug'

# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root == nil
      @root = BSTNode.new(value)
      return @root
    end

    if value <= @root.value
      add_value_to_left(value, @root)
    else
      add_value_to_right(value, @root)
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if value == tree_node.value

    if value < tree_node.value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    found_node = find(value)
    if no_children?(found_node) && @root.value == value
      @root = nil
    elsif no_children?(found_node)
      simple_erase(found_node)
    elsif one_child?(found_node)
      one_child_promotion(found_node)
    else
      two_children_promotion(found_node)
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end

  private
  # optional helper methods go here:

  def add_value_to_left(value, node)
    if node.left.nil?
      new_node = BSTNode.new(value)
      node.left = new_node
      new_node.parent = node
    elsif value <= node.left.value
      add_value_to_left(value, node.left)
    else
      add_value_to_right(value, node.left)
    end
  end

  def add_value_to_right(value, node)
    if node.right.nil?
      new_node = BSTNode.new(value)
      node.right = new_node
      new_node.parent = node
    elsif value <= node.right.value
      add_value_to_left(value, node.right)
    else
      add_value_to_right(value, node.right)
    end
  end

  def no_children?(node)
    node.left.nil? && node.right.nil?
  end

  def one_child?(node)
    (node.left && node.right.nil?) || (node.right && node.left.nil?)
  end

  def simple_erase(found_node)
    parent_node = found_node.parent
    parent_node.left = nil if parent_node.left == found_node
    parent_node.right = nil if parent_node.right == found_node
  end

  def one_child_promotion(node)
    child_node = node.right ? node.right : node.left
    parent_node = node.parent

    if parent_node.left == node
      parent_node.left = child_node
    else
      parent_node.right = child_node
    end
    child_node.parent = parent_node
  end

  def two_children_promotion(deleted_node)
    largest_node_in_left = maximum(deleted_node.left)
    parent_node = deleted_node.parent

    one_child_promotion(largest_node_in_left)

    deleted_node.left.parent = largest_node_in_left
    deleted_node.right.parent = largest_node_in_left

    largest_node_in_left.left = deleted_node.left
    largest_node_in_left.right = deleted_node.right
  end
end
