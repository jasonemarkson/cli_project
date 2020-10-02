# keep track of our parks
# turn our responses into objects
# save all parks created

class Park
    attr_accessor :name, :park_code

    @@all = []

    def initialize(name:, park_code:)
        @name = name
        @park_code = park_code
        @@all << self
    end

    def self.all
        @@all
    end
end