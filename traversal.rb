# frozen-string-literal: true

# Methods for tree traversal
module Traversal
  def postorder(node = root, ordered = [])
    return node if node.nil?

    postorder(node.left, ordered)
    postorder(node.right, ordered)
    ordered << node.data
  end

  def preorder(node = root, ordered = [])
    return node if node.nil?

    ordered << node.data
    preorder(node.left, ordered)
    preorder(node.right, ordered)
    ordered
  end

  def inorder(node = root, ordered = [])
    return node if node.nil?

    inorder(node.left, ordered)
    ordered << node.data
    inorder(node.right, ordered)
    ordered
  end

  def level_order
    return puts 'No root node. Build a tree first!' if root.nil?

    queue = [root]
    ordered = []
    loop do
      break if queue.empty?

      ordered << queue[0].data
      current_node = queue.shift
      queue.append(current_node.left) unless current_node.left.nil?
      queue.append(current_node.right) unless current_node.right.nil?
    end
    ordered
  end

  def find(value, node = root, parent = root)
    return [nil] if node.nil?

    return [node, parent] if node.data == value

    value > node.data ? find(value, node.right, node) : find(value, node.left, node)
  end

  def min_node(node)
    return node if node.left.nil?

    min_node(node.left)
  end

  def height(node)
    return 0 if node.nil?

    left = height(node.left)
    right = height(node.right)
    left > right ? left + 1 : right + 1
  end

  def height_prep(value)
    node = find(value)[0]
    return if node == false

    height(node)
  end

  def depth
    height(root)
  end
end
