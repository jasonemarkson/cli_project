## interactions with user
# contain all of our gets and puts
# control the flow of our program

class CLI

    def start
        puts ""
        puts "Welcome to NatPark Center!"
        ask_user_new_state
        ask_user
        inp = gets.strip.downcase
        while inp != 'exit' do
            if inp == 'list'
                print_park(State.find_by_state(@state).parks)
            elsif inp.to_i > 0 && inp.to_i <= State.find_by_state(@state).parks.length
                park = State.find_by_state(@state).parks[inp.to_i - 1]
                API.get_park_info(park)
                print_park_details(park)
            elsif inp == 'state'
                ask_user_new_state
            elsif inp == 'contact'
                API.get_park_contact_info(park)
                print_contact_details(park)
            else
                puts "Please type in an ACTUAL option SIR! Thank ya very much ;)"
            end
            ask_user
            puts "OR type 'contact' to get park contact info, address, directions"
            inp = gets.strip.downcase
        end
        puts "Goodbye...and happy trails to you!"
    end


    #methods

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
        binding.pry
        puts ""
        puts "
        Quick Info: 
        
            Park Name: #{park.name}

            State: #{park.state}

            Description: #{park.description}
                "
        puts ""
    end

    def ask_user
        puts ""
        puts "Type a number listed to see more park details"
        puts "OR type 'state' to search for another state"
        puts "OR type 'list' to see the list of parks"
        puts "OR type 'exit' to exit"
    end

    def ask_user_new_state
        puts ""
        puts "Find National Parks by entering your state's 2 digit code"
        puts ""
        @state = gets.strip.downcase
        puts ""
        API.get_state(@state)
        puts ""
        parks = State.find_by_state(@state).parks
        print_park(parks)
    end

    
    #want to retrieve the parks phone number; later on more contact information like address, operating hours, URL.
    def print_contact_details(park)
        c = API.get_park_contact_info(park)[0]["phoneNumber"]
        a = API.get_park_info(park)["addresses"][0]
        u = API.get_park_info(park)["url"]
        d = API.get_park_info(park)["directionsInfo"]
        
        puts ""
        puts "Here is all of contact information for #{park.name}:"
        puts ""
        puts ""
        puts "      Phone Number: (#{c[0..2]})#{c[3..5]}-#{c[6..9]}"
        puts ""
        puts "      Address: #{a["line1"]}, #{a["city"]}, #{a["stateCode"]} #{a["postalCode"]}"
        puts ""
        puts "      Website: #{u}"
        puts ""
        puts "      Directions: #{d}"
        puts ""
    end
end