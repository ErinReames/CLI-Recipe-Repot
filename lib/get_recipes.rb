require 'open-uri'
require 'json'
require 'net/http'

class GetRecipes
    URL = "http://www.recipepuppy.com/api/"

    def get_recipes
        uri = URI.parse(URL)
        response = Net::HTTP.get_response(uri)
        response.body
    end
end

recipes = GetRecipes.new.get_recipes
puts recipes
