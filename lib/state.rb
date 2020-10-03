class State
    attr_accessor :name_id, :parks

    @@all = []
    
    def initialize(name_id:, parks:)
        @name_id = name_id
        @parks = []
    end

    def self.all
        @@all
    end
end