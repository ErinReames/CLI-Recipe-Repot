class User < ActiveRecord::Base
    has_many :records
    has_many :recipes, through: :records

    def display_my_recipes
        if self.recipes.count >= 1
        count = 1
        self.recipes.each do |recipe| 
            puts "#{count} #{recipe.name}"
            count +=1
        end
        response = gets.chomp
        recipe = @you.recipes[response - 1]
        my_record = Record.find_by({user_id: @you.id, recipe_id: recipe.id})
        puts "What woould you like to rate this recipe, on a scale of 1 to 5?"
        rating = gets.chomp
        my_record.user_rating = rating
        my_record.save
        else
            puts "Uh-oh looks like you haven't tried any recipes you silly goose!"
        end
    end
end