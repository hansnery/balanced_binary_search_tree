# frozen_string_literal: true

require 'set'

# :nodoc:
class Node
  attr_accessor :data, :left, :right, :counter

  @@counter = Set.new

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
    @@counter << self
  end

  def delete
    @@counter.delete(self)
  end

  def self.count
    @@counter.size
  end

  def self.counter
    @@counter
  end
end
