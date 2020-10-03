# keep track of our parks
# turn our responses into objects
# save all parks created

class Park
    attr_accessor :name, :park_code, :state

    @@all = []

    def initialize(name:, park_code:, state:)
        @name = name
        @park_code = park_code
        @state = state
        @@all << self
    end

    def self.all
        @@all
    end

    #def self.find_by_state(state)
    #    @@all.select { |park| park.state == state.upcase }
    #end
end