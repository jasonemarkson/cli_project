class State
    attr_accessor :name, :parks

    @@all = []
    
    def initialize(name)
        @name = name
        @parks = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_by_state(state)
        @@all.find do |park|
            park.name == state.upcase
        end
    end
end