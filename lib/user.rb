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
            puts Rainbow("That was not an option.").bright.underline.red 
            return false
        end
    end

    def create_or_update_rating(record)
        if record.user_rating
            puts Rainbow("Your previous rating was #{record.user_rating}.\n").bright.red 
        end
        puts Rainbow("What would you like to rate this recipe, on a scale of 1 to 5?\n").bright.red 
        new_rating = gets.chomp
        if new_rating.to_i && new_rating.to_i > 0 && new_rating.to_i < 6
            record.update(user_rating: new_rating.to_i)
            puts Rainbow("\nDone!").bright.red 
        else
            puts Rainbow("That was an invalid rating").bright.underline.red 
        end
    end

    def delete_rating(record)
        puts Rainbow("Are you sure you want to delete - enter 'y' to confirm, press any other key to abort").bright.red 
        response = gets.chomp
        if response == "y"
            record.update(user_rating: nil)
            puts Rainbow("Done!").red.bright
            return true
        end
        puts Rainbow("Aborted!\nReturning you to the menu.").bright.red 
    end

    def update_or_delete__my_recipe_rating(action)
        if self.recipes.count >= 1
            puts Rainbow("Enter the cooresponding number of the recipe you wish to choose. \n").bright.red 
            count = 1
            self.recipes.each do |recipe| 
                puts Rainbow("#{count} #{recipe.name}").bright.red 
                count +=1
            end
            puts "\n"
            record = self.pick_my_recipes
            if record && action == "update"
                create_or_update_rating(record)
            elsif record && action == "delete"
                delete_rating(record)
            else
                puts Rainbow("\nReturning you to the menu.").red.bright
            end
        else
            puts Rainbow("Uh-oh looks like you haven't tried any recipes you silly goose!").red.bright.italic
        end
    end

    def list_recipes
        if self.recipes.count >= 1
            self.recipes.uniq.each do |recipe| 
                puts "\n#{recipe.name}"
                puts "#{recipe.ingredients}"
                puts "#{recipe.description}"
                puts "#{recipe.best_for}"
                if recipe.average > 0
                    puts Rainbow("Rated #{recipe.average} out of 5 stars!\n").bright.red 
                else
                    puts Rainbow("This recipe hasn't been rated yet!").bright.red 
                end
                sleep (0.5)
            end
        else
            puts Rainbow("Uh-oh looks like you haven't tried any recipes you silly goose!").red.bright.italic
            sleep (0.5)
        end
    end
end
 
