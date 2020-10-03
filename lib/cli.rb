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
        puts ""
        puts "Type a number listed to see more details or type 'exit' to exit"
        puts ""
        inp = gets.strip.downcase
        while inp != 'exit' do
            park = Park.find_by_state(@state)[inp.to_i - 1]
            API.get_park_info(park)
        end 
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
end