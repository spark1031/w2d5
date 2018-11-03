require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    hashed_key = key.hash 
    the_bucket = hashed_key % @store.length
    the_list = @store[the_bucket] 
    if the_list.include?(key)
      return true 
    else
      return false
    end
  end

  def set(key, val)
    the_bucket = bucket(key)
    the_list = @store[the_bucket] 
    if the_list.include?(key)
      the_list.update(key, val)
    else
      the_list.append(key, val) 
    end
  end

  def get(key)
    the_bucket = bucket(key)
    the_list = @store[the_bucket] 
    the_list.get(key)
  end

  def delete(key)
    
  end

  def each
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    hashed_key = key.hash 
    hashed_key % @store.length
  end
end
