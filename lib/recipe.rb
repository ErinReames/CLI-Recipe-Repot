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
        count = 1
        puts "\n"
        Recipe.all.each do |recipe| 
            puts "#{count} #{recipe.name}\n "
            count +=1
        end
        select_recipe(all)
    end

    def self.list_rated_recipes(min)
        count = 1
        puts "\n"
        array = all.select {|recipe| recipe.average >= min}
        array.each do |recipe|
            puts "#{count} #{recipe.name}\n "
            count +=1
        end
        select_recipe(array)
    end

    def self.select_recipe(array)
        puts "Enter the number for the recipe you'd like to add.\n"
        response = gets.chomp.to_i
        if response && response  <= array.count
            puts "\nAdded!"
            puts "\n"
            sleep (1)
            puts "Come back and rate it once you try it out!"
            sleep (1)
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