class HashMap
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
end     