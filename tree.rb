# frozen_string_literal: true

# :nodoc:
class Tree
  require_relative 'node'
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
    pretty_print @root
  end

  def build_tree(array, start = 0, end_of_array = array.length - 1)
    return nil if start > end_of_array

    sorted_array = array.sort.uniq
    mid = (start + end_of_array) / 2

    root = Node.new(array[mid])
    root.left = build_tree(sorted_array, start, mid - 1)
    root.right = build_tree(sorted_array, mid + 1, end_of_array)

    root
  end

  def insert(root, value)
    return Node.new(value) if root.nil?

    if value < root.data
      root.left = insert(root.left, value)
    elsif value > root.data
      root.right = insert(root.right, value)
    end
    root
  end

  def smallest_node(node = @root)
    current = node
    current = current.left until current.left.nil?
    current
  end

  def delete(root, value)
    return root if root.nil?

    if value < root.data
      root.left = delete(root.left, value)
    elsif value > root.data
      root.right = delete(root.right, value)
    elsif root.left.nil?
      result = root.right
      root = nil
      return result
    elsif root.right.nil?
      result = root.left
      root = nil
      return result
    else
      result = smallest_node(root.right)
      root.data = result.data
      root.right = delete(root.right, result.data)
    end
    root
  end

  def find(root, value)
    return root if root.nil? || root.data == value

    return find(root.right, value) if root.data < value

    find(root.left, value)
  end

  def level_order(root, result = [], queue = Queue.new)
    return root if root.nil?

    queue << root
    until queue.empty?
      current = queue.pop
      result << current.data
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
    end
    result
  end

  def inorder(root = @root)
    return if root.nil?

    inorder(root.left)
    puts root.data
    inorder(root.right)
  end

  def preorder(root = @root)
    return if root.nil?

    puts root.data
    preorder(root.left)
    preorder(root.right)
  end

  def postorder(root = @root)
    return if root.nil?

    postorder(root.left)
    preorder(root.right)
    puts root.data
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

test = Tree.new([1, 2, 3, 4, 5, 6, 7])
test.insert(test.root, 8)
test.pretty_print
# p test.inorder
# p test.preorder
p test.postorder
