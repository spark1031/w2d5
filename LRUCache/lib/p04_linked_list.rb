require 'byebug'

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next
    self.next.prev = self.prev
    # debugger
    self.prev = nil
    self.next = nil
  end
end

class LinkedList
  include Enumerable
  
  attr_reader :head, :tail
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    return nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    return false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    previous_node = last
    new_node.next = @tail
    new_node.prev = previous_node
    previous_node.next = new_node
    @tail.prev = new_node
  end

  def update(key, val)
    
    self.each do |node|
      node.val = val if node.key == key
    end
    
  end

  def remove(key)
    removed_node = nil
    self.each do |node|
      if node.key == key
        removed_node = node
        node.prev.next = node.next
        node.next.prev = node.prev
      end
    end
    removed_node.prev = nil
    removed_node.next = nil
    removed_node
  end

  def each(&prc)
    next_el = @head.next
    until next_el == @tail
      prc.call(next_el)
      next_el = next_el.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
