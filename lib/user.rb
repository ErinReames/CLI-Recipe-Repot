class User < ActiveRecord::Base
    has_many :records
    has_many :recipes, through: :records

    attr_accessor :my_record, :recipe
        
    def pick_my_recipes
        response = gets.chomp.to_i 
        @recipe = self.recipes[response - 1]
        record = Record.find_by({user_id: self.id, recipe_id: recipe.id})
        record
    end

    def create_or_update_rating(record)
        if record.user_rating
            puts "Your previous rating was #{record.user_rating}."
        end
        puts "What would you like to rate this recipe, on a scale of 1 to 5?"
        new_rating = gets.chomp.to_i
        record.update(user_rating: new_rating)
        #record.user_rating = rating
        record.save
    end

    def delete_rating(my_record)
        puts "Are you sure you want to delete - press y for yes or n for no"
        response = gets.chomp
        if response == "y"
            my_record.update(user_rating: nil)
        end
    end

    def list_recipes
        if self.recipes.count >= 1
            self.recipes.uniq.each do |recipe| 
                puts "#{recipe.name}"
                puts "#{recipe.ingredients}"
                puts "#{recipe.description}"
                puts "#{recipe.avg_rating}\n\n"
                sleep (0.5)
            end
        else
            puts "Uh-oh looks like you haven't tried any recipes you silly goose!"
        end
    end

    def update_my_recipe_rating
        if self.recipes.count >= 1
        puts "Enter the cooresponding number of the recipe you wish to rate."
        count = 1
        self.recipes.each do |recipe| 
            puts "#{count} #{recipe.name}"
            count +=1
        end
        record = pick_my_recipes
        create_or_update_rating(record)
        @recipe.avg_rating
        self.save 
        puts "Done!"
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
        delete_rating(record)
        @recipe.avg_rating
        puts "Done!"
        else
        puts "Uh-oh looks like you haven't tried any recipes you silly goose!"
        end
    end
end
 
