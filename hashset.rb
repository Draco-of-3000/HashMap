class HashSet
    def initialize
        @buckets = Array.new(16) { [] }
        @load_factor = 0.75
        @size = 0
    end
  
    def hash(key)
        hash_code = 0
        prime_number = 31
  
        key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
  
        hash_code
    end
  
    def add(key)
        index = hash(key) % @buckets.length
  
        raise IndexError, "Index out of bounds" if index.negative? || index >= @buckets.length
  
        bucket = @buckets[index]
  
        unless bucket.include?(key)
            bucket << key
            @size += 1
            grow_buckets if @size.to_f / @buckets.length > @load_factor
        end
    end
  
    def contains?(key)
        index = hash(key) % @buckets.length
  
        raise IndexError, "Index out of bounds" if index.negative? || index >= @buckets.length
  
        bucket = @buckets[index]
  
        bucket.include?(key)
    end
  
    def remove(key)
        index = hash(key) % @buckets.length
  
        raise IndexError, "Index out of bounds" if index.negative? || index >= @buckets.length
  
        bucket = @buckets[index]
  
        if bucket.include?(key)
            bucket.delete(key)
            @size -= 1
        end
    end
  
    def size
        @size
    end
  
    def clear
        @buckets = Array.new(16) { [] }
        @size = 0
    end
  
    def grow_buckets
        new_buckets = Array.new(@buckets.length * 2) { [] }
  
        @buckets.flatten.each do |key|
            new_index = hash(key) % new_buckets.length
            new_buckets[new_index] << key
        end
  
        @buckets = new_buckets
    end
  end
  
  # Example usage
  set = HashSet.new
  set.add("key1")
  set.add("key2")
  set.add("key3")
  
  puts "Set size: #{set.size}"
  puts "Contains key2? #{set.contains?("key2")}"
  puts "Contains key4? #{set.contains?("key4")}"
  
  set.remove("key2")
  puts "After removing key2, set size: #{set.size}"
  
  set.clear
  puts "After clearing, set size: #{set.size}"
  