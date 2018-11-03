require 'byebug'
class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    @store.length > num && 0 <= num
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self.include?(num)
  end

  def remove(num)
    # self[num].each do |int|
    #   int.delete(num) if int.include?(num)
    # end
    
    if self[num].include?(num)
      self[num].delete(num)
    end
    
  end

  def include?(num)
    # @store[num].include?(num)
    self[num].each do |int|
      return true if int == num
    end
    false
  end

  private

  def [](num) #num = 1 -> 1 % 20 = 1
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)

    resize! if @count >= num_buckets
    return if self.include?(num)
    self[num] << num
    @count += 1
  
  end

  def remove(num)
    return unless self.include?(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].each do |int|
      if num == int 
        return true
      end
    end
    return false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }

    @store.each do |bucket|
      bucket.each do |element|
        new_store[element % (num_buckets * 2)] << element
      end
    end
    @store = new_store
    
    
  end
end
