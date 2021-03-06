# keep track of our parks
# turn our responses into objects
# save all parks created

class Park
    attr_accessor :name, :park_code, :state, :description, :phone_number, :directions, :url, :address

    @@all = []

    def initialize(name:, park_code:, state:, description:)
        @name = name
        @park_code = park_code
        @state = state
        @description = description
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find (park)
        @@all.find { |p| p == park }
    end
    
end