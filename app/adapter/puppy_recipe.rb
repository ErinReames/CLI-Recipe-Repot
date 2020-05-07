require 'pry'
require 'net/http'
require 'open-uri'
require 'json'
require 'rest-client'
require 'faker'

class PuppyRecipe
    def self.get_data(ingredient,page)
        url = "http://www.recipepuppy.com/api/?i=#{ingredient}&p=#{page.to_i}"
        response = RestClient.get(url)
        response_body = response.body
        json_response = JSON.parse(response_body)
        recipes = json_response["results"].map do |recipe|
            {name: recipe["title"].delete("\n"), ingredients: recipe["ingredients"], description: Faker::Food.description}
        end
        # binding.pry
    end
end
# PuppyRecipe.get_data("gravy",2)
# puts "Done!"