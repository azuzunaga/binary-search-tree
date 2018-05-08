require 'binary_search_tree'

def kth_largest(tree_node, k)
  traversed = reverse_traversal(tree_node)
  traversed[k - 1]
end

def reverse_traversal(tree_node)
  return [tree_node] if !tree_node.left && !tree_node.right

  right = tree_node.right ? reverse_traversal(tree_node.right) : []
  left = tree_node.left ? reverse_traversal(tree_node.left) : []

  right + [tree_node] + left
end
