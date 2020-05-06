#class for the recipe database we are pulling from
class Recipe < ActiveRecord::Base
    has_many :records 
    has_many :users, through: :records
    attr_accessor :new_array
    
    def avg_rating
        ratings_array = self.records.map{|r|r.user_rating}.compact
        if ratings_array.count > 0
            new_rating = ratings_array.inject{|sum,v|sum+v}/(ratings_array.count)
        self.update(rating: new_rating)
        #self.save
        new_rating
        else 
            puts "This recipe has not been rated yet"
        end
    end

    def self.list_all_recipes
        count = 1
        puts "\n"
        Recipe.all.each do |recipe| 
            puts "#{count} #{recipe.name}\n"
            count +=1
        end
        puts "Enter the number for the recipe you'd like to add."
        select_recipe(Recipe.all)
    end

    def self.list_rated_recipes(min)
        count = 1
        @new_array = []
        puts "\n"
        Recipe.all.each do |recipe| 
            if recipe.rating && recipe.rating >= min.to_i
            puts "#{count} #{recipe.name}\n"
            @new_array << recipe
            count +=1
            end
        end
        puts "Enter the number for the recipe you'd like to add."
        select_recipe(@new_array)
    end

    def self.select_recipe(array)
        response = gets.chomp
        if response.to_i && response.to_i <= array.count
            puts "Added!"
            sleep (1)
            array[(response.to_i - 1)]
        else
            puts "Sorry, that is an invalid input."
            sleep (1)
            puts "We will not return you to the menu"
            sleep (1)
            nil
        end
    end

end