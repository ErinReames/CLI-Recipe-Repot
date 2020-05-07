#class for the recipe database we are pulling from
class Recipe < ActiveRecord::Base
    has_many :records 
    has_many :users, through: :records

    def average
        records.average(:user_rating).round
    end

    def self.list_all_recipes
        select_recipe(all)
    end

    def self.list_rated_recipes(min)
        array = all.select {|recipe| recipe.average >= min}
        if array.count == 0 
            puts Rainbow("Sorry! It looks like we don't have a recipe rated that highly at the moment.").red.bright
        else
            select_recipe(array)
        end
    end

    def self.list_by_diet(diet)
        array = all.select {|recipe| recipe.best_for == diet}
        if array.count == 0
            puts Rainbow("Sorry! It looks like we don't have a recipe tailored for that diet yet.").red.bright
        else
            select_recipe(array)
        end
    end

    def self.select_recipe(array)
        puts "\n"
        puts Rainbow("Enter the number for the recipe you'd like to add.").red.bright
        sleep (1)
        puts "\n"
        count = 1
        array.each do |recipe|
            puts Rainbow("#{count} - #{recipe.name}\n ").red.bright
            count +=1
        end
        response = gets.chomp.to_i
        if response > 0 && response <= array.count
            puts Rainbow("\nAdded!").red.bright
            sleep (0.5)
            puts "\n"
            puts Rainbow("Come back and rate it once you try it out!").red.bright
            array[(response - 1)]
        else
            puts Rainbow("Sorry, that is an invalid input.").red.bright.underline
            puts "\n"
            sleep (1)
            puts Rainbow("We will now return you to the menu").red.bright.underline 
            nil
        end
    end
end