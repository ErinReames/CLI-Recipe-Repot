class User < ActiveRecord::Base
    has_many :records
    has_many :recipes, through: :records
        
    def pick_my_recipes(array)
        response = gets.chomp.to_i 
        puts "\n"
        if response < (array.count + 1) && response > 0
            Record.find_by({user_id: self.id, recipe_id: (array[response - 1]).id})
        else 
            puts Rainbow("That was not an option.").bright.underline.red 
            sleep (1)
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
            sleep (1)
        else
            puts Rainbow("\nThat was an invalid rating").red.bright.underline
            sleep (1)
        end
    end

    def delete_rating(record)
        puts Rainbow("Are you sure you want to delete - enter 'y' to confirm, press any other key to abort. \n").bright.red 
        response = gets.chomp
        if response == "y"
            record.update(user_rating: nil)
            puts Rainbow("\nDone!").red.bright
            return true
        end
        puts Rainbow("Aborted!\nReturning you to the menu.").bright.red.underline
        sleep (1)
    end

    def update_or_delete__my_recipe_rating(action)
        if self.recipes.count >= 1
            count = 1
            temp = []
            if action == "create"
                self.recipes.uniq.each do |recipe| 
                    if Record.find_by({user_id: self.id, recipe_id: recipe.id}).user_rating == nil
                        puts Rainbow("#{count} - #{recipe.name} \n").bright.red
                        count +=1
                        temp << recipe
                    end
                end
                temp
            else
                self.recipes.uniq.each do |recipe| 
                    if Record.find_by({user_id: self.id, recipe_id: recipe.id}).user_rating != nil
                        puts Rainbow("#{count} - #{recipe.name} \n").bright.red 
                        count +=1
                        temp << recipe
                    end
                end
                temp
            end
            puts "\n"
            if temp.count > 0
                puts Rainbow("Enter the corresponding number of the recipe you wish to choose.").red.bright
                sleep(1)
                puts "\n"
                record = self.pick_my_recipes(temp)
                system "clear"
                if record && action == "update" || record && action == "create"
                    create_or_update_rating(record)
                elsif record && action == "delete"
                    delete_rating(record)
                else
                    puts Rainbow("\nReturning you to the menu.").red.bright
                    sleep (1)
                end
            else
                puts Rainbow("Uh-oh looks like you dont have any recipes to change yet! \nTry another rating menu option!").red.bright.italic
                sleep (1)
            end
        else
            puts Rainbow("Uh-oh looks like you haven't tried any recipes you silly goose!").red.bright.italic
            sleep (1)
        end
    end

    def list_recipes
        if self.recipes.count >= 1
            self.recipes.uniq.each do |recipe| 
                puts Rainbow("\nName: #{recipe.name}").red.bright
                puts Rainbow("Ingredients: #{recipe.ingredients}").red.bright
                puts Rainbow("Description: #{recipe.description}").red.bright
                puts Rainbow("This recipe is tailored for #{recipe.best_for} diets").red.bright
                if recipe.average > 0
                    puts Rainbow("Rated #{recipe.average} out of 5 stars!").bright.red 
                else
                    puts Rainbow("This recipe hasn't been rated yet!").bright.red 
                end
            end
            sleep (1.5)
            puts Rainbow(" \n\nPress enter to return to the menu.").bright.red.underline
            gets.chomp
        else
            puts Rainbow("Uh-oh looks like you haven't tried any recipes you silly goose!").red.bright.italic
            sleep (0.8)
        end
    end
end
 
