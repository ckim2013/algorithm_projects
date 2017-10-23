require_relative 'binary_search_tree'
def kth_largest(tree_node, k)
  bst = BinarySearchTree.new
  sorted = bst.in_order_traversal(tree_node)
  value = sorted[sorted.length - k]
  bst.find(value, tree_node)
end
