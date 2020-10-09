# handle all of our API requests
class API
    
    def self.get_state(state)
        url = "https://developer.nps.gov/api/v1/parks?stateCode=#{state}&api_key=a0pycXYjNhLyJ0vQ3vQI9UfbjXN0Ii7Gf8aUzM74"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        parks = JSON.parse(response)["data"]
        new_state = State.new(state.upcase)
        parks.each do |p|
            new_park = Park.new(name: p["fullName"], park_code: p["parkCode"], state: state.upcase, description: p["description"])
            new_state.parks << new_park
        end
    end

    def self.get_park_info(park)
        url = "https://developer.nps.gov/api/v1/parks?parkCode=#{park.park_code}&api_key=a0pycXYjNhLyJ0vQ3vQI9UfbjXN0Ii7Gf8aUzM74"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        park_code = JSON.parse(response)["data"][0]
        park_activities_list = park_code["activities"]
        park.url = park_code["url"]
        park.address = park_code["addresses"][0]
        park.directions = park_code["directionsInfo"]
    end

    def self.get_park_contact_info(park)
        url = "https://developer.nps.gov/api/v1/parks?parkCode=#{park.park_code}&api_key=a0pycXYjNhLyJ0vQ3vQI9UfbjXN0Ii7Gf8aUzM74"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        contact_info = JSON.parse(response)["data"][0]["contacts"]["phoneNumbers"]
        contact_info.each do |x|
            park.phone_number = x["phoneNumber"]
        end 
    end

end