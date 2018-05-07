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
    # byebug
    return tree_node if tree_node.value == value
    return nil if tree_node.right.nil? && tree_node.left.nil?

    case value <=> tree_node.value
    when 1
      find(value, tree_node.right)
    when 0, -1
      find(value, tree_node.left)
    end
  end

  def delete(value)
    return @root = nil if @root.value == value && childless?(@root)

    to_delete = find(value)
    left = to_delete.parent.left == to_delete

    if childless?(to_delete)
      if left
        to_delete.parent.left = nil
      else
        to_delete.parent.right = nil
      end
    elsif two_children?(to_delete)
      handle_both_kids(to_delete, left)
    else
      handle_children(to_delete, left)
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
     return tree_node if tree_node.right.nil?

     maximum(tree_node.right)
  end

  def childless?(node)
    node.left.nil? && node.right.nil?
  end

  def two_children?(node)
    node.left && node.right
  end

  def handle_children(node, left)
    left_child = node.left
    right_child = node.right

    if left_child && !right_child
      if left
        node.parent.left = left_child
      else
        node.parent.right = left_child
      end
    elsif !left_child && right_child
      if left
        node.parent.left = right_child
      else
        node.parent.right = right_child
      end
    end
  end

  def handle_both_kids(node, left)
    max_node = maximum(node.left)

    max_node.left.parent = max_node.parent
    max_node.parent.right = max_node.left

    if left
      node.parent.left = max_node
    else
      node.parent.right = max_node
    end

    max_node.parent = node.parent
  end

  def depth(tree_node = @root)
    depth_charge = 0
    return depth_charge if childless?(tree_node)

    left_depth = tree_node.left ? depth(tree_node.left) + 1 : 0
    right_depth = tree_node.right ? depth(tree_node.right) + 1 : 0

    depth_charge = left_depth > right_depth ? left_depth : right_depth

    depth_charge
  end

  def is_balanced?(tree_node = @root)
    return true if childless?(tree_node)

    balanced_kids = depth(tree_node.left) - depth(tree_node.right) < 2

    left_balanced = tree_node.left ? is_balanced?(tree_node.left) : true
    right_balanced = tree_node.right ? is_balanced?(tree_node.right) : true

    balanced_kids && left_balanced && right_balanced
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return [tree_node.value] if childless?(tree_node)

    left = tree_node.left ? in_order_traversal(tree_node.left) : []
    right = tree_node.right ? in_order_traversal(tree_node.right) : []

    left + [tree_node.value] + right
  end


  private
  # optional helper methods go here:
  def find_spot(parent_node, value)
    case value <=> parent_node.value
    when 1
      if parent_node.right.nil?
        parent_node.right = BSTNode.new(value)
        parent_node.right.parent = parent_node
      else
        find_spot(parent_node.right, value)
      end
    when -1, 0
      if parent_node.left.nil?
        parent_node.left = BSTNode.new(value)
        parent_node.left.parent = parent_node
      else
        find_spot(parent_node.left, value)
      end
    end
  end
end
