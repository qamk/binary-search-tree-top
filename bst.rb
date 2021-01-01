# frozen-string-literal: true

require_relative 'node.rb'
require_relative 'traversal.rb'
require_relative 'commands.rb'


# Class representing a Balanced Binary Search Tree (BST)
class BST
  attr_reader :root
  include Traversal
  include Commands
  def initialize
    array = Array.new(rand(5..15)) { rand(230) }.sort.uniq # might use my merge_sort later
    @root = build_tree(array)
    play
  end

  def play
    welcome
    loop do
      prompt
      response = gets.chomp.downcase
      break if %w[q driver].include? response

      next unless valid? response

      action = use[response]
      call_methods(action)
    end
  end

  def build_tree(array)
    return if array.empty?

    mid = array.size / 2
    left = array[0...mid]
    right = array[mid + 1..-1]
    Node.new(array[mid], build_tree(left), build_tree(right))
  end

  def insert(value, parent = root, node = root)
    if node.nil?
      puts "Inserted \e[32m#{value}\e[0m!"
      set_node(parent, Node.new(value), value)
      return
    end
    return puts "\e[1mDuplicate entered\e[0m. That value already exists." if parent.data == value

    puts "Value: \e[31m#{value}\e[0m Node: \e[33m#{node.data}\e[0m"
    value > node.data ? insert(value, node, node.right) : insert(value, node, node.left)
  end

  def balanced?
    diff = height(root.left) - height(root.right)
    diff.abs <= 1
  end

  def rebuild
    new_tree_contents = Array.new(5..15) { rand(230) }.sort.uniq
    build_tree(new_tree_contents)
  end

  def rebalance
    return puts 'Tree is already balanced' if balanced?

    @root = build_tree(inorder)
  end

  def delete_prep(value, parent = root, node = root)
    return puts 'Value not found' if node.nil?

    if value < node.data
      delete_prep(value, node, node.left)
    elsif value > node.data
      delete_prep(value, node, node.right)
    else
      delete(value, parent, node)
      puts "Deleted \e[95m#{value}\e[0m"
    end
  end

  # By another Odin Project Student (slightly tweaked)
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}\e[38;5;#{node.data}m#{node.data}\e[0m"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def delete(value, parent, node)
    if node.left.nil? # Has a right child / No children
      set_node(parent, node.right, value)
    elsif node.right.nil? # Has a left child / No children
      set_node(parent, node.left, value)
    else # Two children
      min = min_node(node.right)
      min = min.right unless min.right.nil?
      min_data = min.data
      delete_prep(min_data)
      set_node(parent, min_data, value, true)
    end
  end

  def set_node(parent, new_value, ref_value, data_only = false)
    if data_only
      parent.left.data = new_value unless ref_value > parent.data
      parent.right.data = new_value unless ref_value < parent.data
    else
      parent.left = new_value unless ref_value > parent.data
      parent.right = new_value unless ref_value < parent.data
    end
  end
end
BST.new
