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

    hash_map = HashMap.new
    hash_map.set("Carlos", "I am the old value.")
    hash_map.set("Carla", "I am a different key.")
    hash_map.set("Carlos", "I am the new value.")

    # Buckets illustration purposes
    hash_map.instance_variable_get(:@buckets).each_with_index do |bucket, index|
        puts "Bucket #{index}: #{bucket.inspect}"
    end
end     