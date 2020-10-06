## interactions with user
# contain all of our gets and puts
# control the flow of our program

class CLI

    def start
        puts ""
        puts "Welcome to NatPark Center!"
        puts ""
        puts "Find National Parks by entering your state's 2 digit code"
        puts ""
        @state = gets.strip.downcase
        puts ""
        API.get_state(@state)
        puts ""
        parks = Park.all
        print_park(parks)
        ask_user
        inp = gets.strip.downcase
        while inp != 'exit' do
            if inp = 'list'
                binding.pry
                print_park(State.find_by_state(@state).parks)
            elsif
                park = State.find_by_state(@state).parks[inp.to_i - 1]
                API.get_park_info(park)
                print_park_details(park)
            end
            ask_user
            inp = gets.strip.downcase
        end
        puts "Goodbye and happy trails to you!"
    end

    def print_park(p)
        puts ""
        puts "Take a look at these beautiful attraction(s) in #{@state.upcase}:"
        puts ""
        p.each_with_index do |obj, i|
            puts "#{i + 1}. #{obj.name}"
        end
        puts ""
    end

    def print_park_details(park)
        puts ""
        puts "#{park.name}"
        puts ""
        binding.pry
    end

    def ask_user
        puts ""
        puts "Type a number listed to see more park details"
        puts "OR type 'name' to search for another park"
        puts "OR type 'list' to see the list of parks"
        puts "OR type 'exit' to exit"
        puts ""
    end
end