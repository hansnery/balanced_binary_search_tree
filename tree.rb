# frozen_string_literal: true

# :nodoc:
class Tree
  require_relative 'node'
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array, start = 0, end_of_array = array.length - 1)
    return nil if start > end_of_array

    sorted_array = array.sort.uniq
    mid = (start + end_of_array) / 2

    root = Node.new(array[mid])
    root.left = build_tree(sorted_array, start, mid - 1)
    root.right = build_tree(sorted_array, mid + 1, end_of_array)

    pretty_print root
    p sorted_array
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

test = Tree.new([1, 2, 3, 4, 5, 6, 7])
# p test.array
