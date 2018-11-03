class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashed = 0
    self.each_with_index do |num, idx|
      hashed += (num * idx).hash
    end
    hashed
  end
end

class String
  def hash
    hashed = 0
    alpha = ("a".."z").to_a
    self.each_char.with_index do |ch, idx|
      hashed += (alpha.index(ch.downcase) + idx).hash
    end
    hashed  
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = 0
    self.keys.each do |key|
      hashed += key.hash
    end
    hashed
  end
end
