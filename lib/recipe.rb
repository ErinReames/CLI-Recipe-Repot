#class for the recipe database we are pulling from
class Recipe < ActiveRecord::Base
    has_many :records 
    has_many :users, through: :records

    def self.every_average
        array = all.map do |recipe|
           [recipe.id, recipe.records.average(:user_rating).round]
        end
        hash = Hash[array.map {|key, value| [key, value]}]
        hash
    end

    def average
        records.average(:user_rating).round
    end

    def self.list_all_recipes
        select_recipe(all)
    end

    def self.list_rated_recipes(min)
        array = all.select {|recipe| recipe.average >= min}
        select_recipe(array)
    end

    def self.list_by_diet(diet)
        array = all.select {|recipe| recipe.best_for == diet}
        if array.count == 0
            puts "Sorry! It looks like we don't have a recipe tailored for that diet yet."
        else
            select_recipe(array)
        end
    end

    def self.select_recipe(array)
        puts "\n"
        count = 1
        array.each do |recipe|
            puts "#{count} #{recipe.name}\n "
            count +=1
        end
        puts "Enter the number for the recipe you'd like to add.\n"
        response = gets.chomp.to_i
        if response && response  <= array.count
            puts "\nAdded!"
            sleep (0.5)
            puts "\n"
            puts "Come back and rate it once you try it out!"
            sleep (0.5)
            array[(response - 1)]
        else
            puts "Sorry, that is an invalid input."
            puts "\n"
            sleep (1)
            puts "We will now return you to the menu"
            nil
        end
    end
end