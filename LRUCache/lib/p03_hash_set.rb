class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    return if self.include?(key)
    self[key] << key
    @count += 1
  end

  def include?(key)
    self[key].each do |int|
      if key == int 
        return true
      end
    end
    return false
  end

  def remove(key)
    return unless self.include?(key)
    self[key].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    key = num.hash
    @store[key % num_buckets]
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
