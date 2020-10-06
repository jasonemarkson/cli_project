# keep track of our parks
# turn our responses into objects
# save all parks created

class Park
    attr_accessor :name, :park_code, :state, :designation, :activities

    @@all = []

    def initialize(name:, park_code:, state:, designation:)
        @name = name
        @park_code = park_code
        @state = state
        @designation = designation
        @activities = []
        @@all << self
        #binding.pry 
    end

    def self.all
        @@all
    end

    
end