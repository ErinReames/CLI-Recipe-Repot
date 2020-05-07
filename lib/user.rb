class User < ActiveRecord::Base
    has_many :records
    has_many :recipes, through: :records
        
    def pick_my_recipes
        response = gets.chomp.to_i 
        puts "\n"
        if self.recipes[response - 1].class == String && response > 0
            Record.find_by({user_id: self.id, recipe_id: (self.recipes[response - 1]).id})
        else 
            puts "That was not an option."
            return false
        end
    end

    def create_or_update_rating(record)
        if record.user_rating
            puts "Your previous rating was #{record.user_rating}.\n"
        end
        puts "What would you like to rate this recipe, on a scale of 1 to 5?\n"
        new_rating = gets.chomp
        if new_rating.to_i && new_rating.to_i > 0 && new_rating.to_i < 6
            record.update(user_rating: new_rating.to_i)
            puts "\nDone!"
        else
            puts "\nThat was an invalid rating"
        end
    end

    def delete_rating(record)
        puts "Are you sure you want to delete - enter 'y' to confirm, press any other key to abort"
        response = gets.chomp
        if response == "y"
            record.update(user_rating: nil)
            puts "Done!"
            return true
        end
        puts "Aborted!\nReturning you to the menu."
    end

    def update_or_delete__my_recipe_rating(action)
        if self.recipes.count >= 1
            puts "Enter the cooresponding number of the recipe you wish to choose."
            sleep(1)
            puts "\n"
            count = 1
            self.recipes.uniq.each do |recipe| 
                puts "#{count} - #{recipe.name}"
                count +=1
            end
            puts "\n"
            record = self.pick_my_recipes
            if record && action == "update"
                create_or_update_rating(record)
            elsif record && action == "delete"
                delete_rating(record)
            else
                puts "\nReturning you to the menu."
            end
        else
            puts "Uh-oh looks like you haven't tried any recipes you silly goose!"
        end
    end

    def list_recipes
        if self.recipes.count >= 1
            self.recipes.uniq.each do |recipe| 
                puts "\nName: #{recipe.name}"
                puts "Ingredients: #{recipe.ingredients}"
                puts "Description: #{recipe.description}"
                puts "This recipe is tailored for #{recipe.best_for} diets"
                if recipe.average > 0
                    puts "Rated #{recipe.average} out of 5 stars!\n"
                else
                    puts "This recipe hasn't been rated yet!"
                end
            end
        else
            puts "Uh-oh looks like you haven't tried any recipes you silly goose!"
        end
    end
end
 
