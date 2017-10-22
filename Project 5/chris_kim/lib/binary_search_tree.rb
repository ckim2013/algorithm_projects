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
    # Hibbard deletion
    deleted_node = find(value)

    if no_children?(deleted_node) && @root.value == value
      @root = nil
    elsif no_children?(deleted_node)
      simple_erase(deleted_node)
    elsif one_child?(deleted_node)
      one_child_promotion(deleted_node)
    else
      two_children_promotion(deleted_node)
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil? || (tree_node.left.nil? && tree_node.right.nil?)
    left = 0
    right = 0
    if tree_node.left && tree_node.right.nil?
      left += 1
      left += depth(tree_node.left)
    end

    if tree_node.right && tree_node.left.nil?
      right += 1
      right += depth(tree_node.right)
    end

    if tree_node.right && tree_node.left
      left += 1
      right += 1
      left += depth(tree_node.left)
      right += depth(tree_node.right)
    end

    left > right ? left : right
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    return true if tree_node.left.nil? && tree_node.right.nil?
    left_subtree = tree_node.left if tree_node.left
    right_subtree = tree_node.right if tree_node.right

    left_depth = depth(left_subtree)
    right_depth = depth(right_subtree)

    if (left_depth - right_depth).abs > 1 || !is_balanced?(left_subtree) || !is_balanced?(right_subtree)
      false
    else
      true
    end
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

  def simple_erase(deleted_node)
    parent_node = deleted_node.parent
    parent_node.left = nil if parent_node.left == deleted_node
    parent_node.right = nil if parent_node.right == deleted_node
  end

  def one_child_promotion(node)
    child_node = node.right ? node.right : node.left
    assign_new_parent_child_relationship(node, child_node)
  end

  def two_children_promotion(deleted_node)
    max_node_in_left = maximum(deleted_node.left)

    one_child_promotion(max_node_in_left)

    deleted_node.left.parent = max_node_in_left
    deleted_node.right.parent = max_node_in_left

    max_node_in_left.left = deleted_node.left
    max_node_in_left.right = deleted_node.right

    assign_new_parent_child_relationship(deleted_node, max_node_in_left)
  end

  def assign_new_parent_child_relationship(node_1, node_2)
    parent_node = node_1.parent

    if parent_node.left == node_1
      parent_node.left = node_2
    else
      parent_node.right = node_2
    end

    node_2.parent = parent_node
  end
end
