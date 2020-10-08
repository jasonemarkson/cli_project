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
                API.get_park_info(park) if !park.url
                print_park_details(park)
                puts ""
                puts "Type 'contact' to get park contact info, address, directions"
                puts ""
            elsif inp == 'state'
                ask_user_new_state
            elsif inp == 'contact'
                API.get_park_contact_info(park) if !park.phone_number
                print_contact_details(park)
            else
                puts ""
                puts "Please type in an ACTUAL option SIR! Thank ya very much ;)"
                puts ""
            end
            ask_user
            inp = gets.strip.downcase
        end
        puts "Goodbye..."
        sleep 1 
        puts "...and happy trails to you!"
    end


    #methods

    def print_park(p)
        puts ""
        puts "Take a look at the beautiful attraction(s) in #{@state.upcase}:"
        puts ""
        p.each_with_index do |obj, i|
            puts "#{i + 1}. #{obj.name}"
        end
        puts ""
    end

    def print_park_details(park)
        puts ""
        puts "
        ------------------------------------------------------------------------------------
        Park Name: #{park.name}
        ------------------------------------------------------------------------------------
        State: #{park.state}
        ------------------------------------------------------------------------------------
        Description: #{park.description} 
        ------------------------------------------------------------------------------------
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
        valid_input = ["al", "ak", "az", "ar", "ca", "co", "ct", "de", "dc", "fl", "ga", "hi", "id", "il", "in", "ia", "ks", "ky", "la", "me", "md", "ma", "mi", "mn", "ms", "mo", "mt", "ne", "nv", "nh", "nj", "nm", "ny", "nc", "nd", "oh", "ok", "or", "pa", "ri", "sc", "sd", "tn", "tx", "ut", "vt", "va", "wv", "wi", "wy", "as", "gu", "mh", "fm", "mp", "pw", "pr", "vi"]
        puts ""
        puts "Find National Parks by entering your state's 2 letter code"
        puts ""
        @state = gets.strip.downcase
        until valid_input.include?(@state)
            puts ""
            puts "Invalid 2 letter state code. Please try again."
            @state = gets.strip.downcase
        end 
        puts ""
        if !State.find_by_state(@state)
            API.get_state(@state)
        end
        puts ""
        parks = State.find_by_state(@state).parks
        print_park(parks)
    end

    
    #want to retrieve the parks phone number; later on more contact information like address, operating hours, URL.
    #already called on api, access the attributes of the object now
    def print_contact_details(park)
        binding.pry
        puts ""
        puts "Here is all of contact information for #{park.name}:"
        puts ""
        puts ""
        puts "      Phone Number: #{park.phone_number}"
        puts ""
            if park.address == nil || park.address == ""
                puts "      Address: Refer to Park Website"
            else
                puts "      Address: #{park.address["line1"]}, #{park.address["city"]}, #{park.address["stateCode"]} #{park.address["postalCode"]}"
            end
        puts ""
        puts "      Website: #{park.url}"
        puts ""
            if park.directions == nil || park.directions == ""
                puts "      Address: Refer to Park Website"
            else
                puts "      Directions: #{park.directions}"
            end
        puts ""
    end
end