class User < ActiveRecord::Base
    has_many :records
    has_many :recipes, through: :records
        
    def pick_my_recipes
        response = gets.chomp.to_i 
        if self.recipes[response - 1]
            recipe = self.recipes[response - 1]
            record = Record.find_by({user_id: self.id, recipe_id: recipe.id})
            record
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
            puts "\n5Done!"
        else
            puts "That was an invalid rating"
        end
    end

    def delete_rating(record)
        puts "Are you sure you want to delete - enter 'y' to confirm, press any other key to abort"
        response = gets.chomp
        if response == "y"
            record.update(user_rating: nil)
            puts "Done!"
        end
        puts "Returning you to the menu."
    end

    def list_recipes
        if self.recipes.count >= 1
            self.recipes.uniq.each do |recipe| 
                puts "\n#{recipe.name}"
                puts "#{recipe.ingredients}"
                puts "#{recipe.description}"
                if recipe.average > 0
                    puts "#{recipe.average} out of 5 stars!\n"
                else
                    puts "This recipe hasn't been rated yet!"
                end
                sleep (0.5)
            end
        else
            puts "Uh-oh looks like you haven't tried any recipes you silly goose!"
            sleep (0.5)
        end
    end

    def update_my_recipe_rating
        if self.recipes.count >= 1
            puts "Enter the cooresponding number of the recipe you wish to rate. \n"
            count = 1
            self.recipes.each do |recipe| 
                puts "#{count} #{recipe.name}"
                count +=1
            end
            puts "\n"
            record = self.pick_my_recipes
            if record
                create_or_update_rating(record)
            end
        else
            puts "Uh-oh looks like you haven't tried any recipes you silly goose!"
        end
    end

    def delete_my_recipe_rating
        if self.recipes.count >= 1
            count = 1
            self.recipes.each do |recipe| 
                puts "#{count} #{recipe.name}"
                count +=1
            end
            record = pick_my_recipes
            if record
                delete_rating(record)
            end
        else
            puts "Uh-oh looks like you haven't tried any recipes you silly goose!"
        end
    end
end
 
