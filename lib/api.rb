# handle all of our API requests
class API
    
    def self.get_state(state)
        url = "https://developer.nps.gov/api/v1/parks?stateCode=#{state}&api_key=a0pycXYjNhLyJ0vQ3vQI9UfbjXN0Ii7Gf8aUzM74"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        parks = JSON.parse(response)["data"]
        new_state = State.new(state.upcase)
        parks.each do |p|
            new_park = Park.new(name: p["fullName"], park_code: p["parkCode"], state: state.upcase)
            new_state.parks << new_park
        end
    end

    def self.get_park_info(park)
        url = "https://developer.nps.gov/api/v1/parks?parkCode=#{park.park_code}&api_key=a0pycXYjNhLyJ0vQ3vQI9UfbjXN0Ii7Gf8aUzM74"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        park_code = JSON.parse(response)["data"]
    end
end