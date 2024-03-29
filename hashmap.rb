class HashMap
    def initialize
        @buckets = Array.new(16) { [] } #Initialize with separate chaining to handle potential collissions
        @load_factor = 0.75
        @size = 0
    end

    def hash(key)
        hash_code = 0
        prime_number = 31
           
        key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
           
        hash_code
    end

    def set(key, value)
        index = hash(key) % @buckets.length

        # Boundary check for index
        raise IndexError, "Index out of bounds" if index.negative? || index >= @buckets.length

        bucket = @buckets[index]

        #Check for existing key in the bucket
        pair_exists = bucket.find { |pair| pair[0] == key}

        if pair_exists 
            #Update the value if the key already exists
            pair_exists[1] = value 
        else 
            # Add a new key-value pair to the bucket
            bucket << [key, value]
            @size += 1

            #Check if the load factor is exceeded, and grow the buckets if needed
            grow_buckets if @size.to_f / @buckets.length > @load_factor

        end
    end

    def grow_buckets
        new_buckets = Array.new(@buckets.length * 2) { [] }

        #Rehash and redistribute existing key-value pairs to new buckets
        @buckets.flatten.each do |pair|
            new_index = hash(pair[0]) % new_buckets.length
            new_buckets[new_index] << pair
        end

        @buckets = new_buckets
    end

    def get(key)
        index = hash(key) % @buckets.length
      
        #Boundary check for index
        raise IndexError, "Index out of bounds" if index.negative? || index >= @buckets.length
      
        bucket = @buckets[index]
      
        #Find the key in the bucket and return its value
        pair = bucket.find { |pair| pair[0] == key }
        pair ? pair[1] : nil
    end

    def has(key)
        index = hash(key) % @buckets.length
      
        #Boundary check for index
        raise IndexError, "Index out of bounds" if index.negative? || index >= @buckets.length
      
        bucket = @buckets[index]
      
        # Check if the key exists in the bucket
        bucket.any? { |pair| pair[0] == key }
    end
    
    def remove(key)
        index = hash(key) % @buckets.length
      
        #Boundary check for index
        raise IndexError, "Index out of bounds" if index.negative? || index >= @buckets.length
      
        bucket = @buckets[index]
      
        #Find the key in the bucket and remove its entry
        pair_index = bucket.index { |pair| pair[0] == key }
        if pair_index
            pair = bucket.delete_at(pair_index)
            @size -= 1
            pair[1]
        else
            nil
        end
    end

    def length
        @size
    end
    
    def clear
        @buckets = Array.new(16) { [] }
        @size = 0
    end
      
    def keys
        all_keys = []

        @buckets.each do |bucket|
            bucket.each do |pair|
                all_keys << pair[0]
            end
        end

        all_keys
    end

    def values
        all_values = []

        @buckets.each do |bucket|
            bucket.each do |pair|
                all_values << pair[1]
            end
        end

        all_values
    end

    def entries
        all_entries = []

        @buckets.each do |bucket|
            bucket.each do |pair|
                all_entries << pair
            end
        end

        all_entries
    end
      
    
    # Buckets illustration purposes
    #hash_map.instance_variable_get(:@buckets).each_with_index do |bucket, index|
    #    puts "Bucket #{index}: #{bucket.inspect}"
    #end
end