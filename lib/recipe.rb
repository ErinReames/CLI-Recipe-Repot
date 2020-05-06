#class for the recipe database we are pulling from
class Recipe < ActiveRecord::Base
    has_many :records 
    has_many :users, through: :records
    attr_accessor :new_array
    
    def self.averaged(rating)
        all.select {|recipe| recipe.avg_rating_method.class == Integer && recipe.avg_rating_method >= rating.to_i}
    end

    def avg_rating_method
        ratings_array = self.records.map{|r|r.user_rating}.compact
        if ratings_array.count > 0
            new_rating = ratings_array.inject{|sum,v|sum+v}/(ratings_array.count)
            return new_rating
        else
            return "No rating"
        end
    end

    def avg_rating
        ratings_array = self.records.map{|r|r.user_rating}.compact
        if ratings_array.count > 0
            new_rating = ratings_array.inject{|sum,v|sum+v}/(ratings_array.count)
            return new_rating
        else 
            puts "This recipe has not been rated yet"
            return "No rating"
        end
    end

    def self.list_all_recipes
        count = 1
        puts "\n"
        Recipe.all.each do |recipe| 
            puts "#{count} #{recipe.name}\n "
            count +=1
        end
        puts "Enter the number for the recipe you'd like to add."
        select_recipe(Recipe.all)
    end

    def self.list_rated_recipes(min)
        count = 1
        puts "\n"
        array = Recipe.averaged(min)
        array.each do |recipe|
            puts "#{count} #{recipe.name}\n "
            count +=1
        end
        puts "Enter the number for the recipe you'd like to add."
        select_recipe(array)
    end

    def self.select_recipe(array)
        response = gets.chomp
        if response.to_i && response.to_i <= array.count
            puts "Added!"
            sleep (1)
            puts "Come back and rate it once you try it out!"
            sleep (1)
            array[(response.to_i - 1)]
        else
            puts "Sorry, that is an invalid input."
            sleep (1)
            puts "We will now return you to the menu"
            sleep (1)
            nil
        end
    end

end