#class for the recipe database we are pulling from
class Recipe < ActiveRecord::Base
    has_many :records 
    has_many :users, through: :records
    
    attr_accessor :ratings_array

    def self.list_all_recipes
        count = 1
        Recipe.all.each do |recipe| 
            puts "#{count} #{recipe.name}"
            count +=1
        end
        puts "Enter the number for the recipe you'd like to add."
        select_recipe
    end
    def self.select_recipe
        response = gets.chomp
        Recipe.all[(response.to_i - 1)]
    end
end