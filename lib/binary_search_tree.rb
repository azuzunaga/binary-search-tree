require 'byebug'

# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if root.nil?
      self.root = BSTNode.new(value)
      return root.value
    end

    find_spot(root, value)

  end

  def find(value, tree_node = @root)
  end

  def delete(value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:
  def find_spot(parent_node, value)
    case value <=> parent_node.value
    when 1
      if parent_node.right.nil?
        parent_node.right = BSTNode.new(value)
      else
        find_spot(parent_node.right, value)
      end
    when -1 || 0
      if parent_node.left.nil?
        parent_node.left = BSTNode.new(value)
      else
        find_spot(parent_node.left, value)
      end
    end
  end
end
