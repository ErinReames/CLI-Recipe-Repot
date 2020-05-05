class User < ActiveRecord::Base
    has_many :records
    has_many :recipes, through: :records

    attr_accessor :my_record
        
    def pick_my_recipes
        response = gets.chomp.to_i 
        recipe = self.recipes[response - 1]
        my_record = Record.find_by({user_id: self.id, recipe_id: recipe.id})
        my_record
    end

    def create_or_update_rating(my_record)
        puts "What would you like to rate this recipe, on a scale of 1 to 5?"
        rating = gets.chomp.to_i
        my_record.user_rating = rating
        my_record.save
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
            count = 1
            self.recipes.each do |recipe| 
                puts "#{recipe.name}"
                puts "#{recipe.ingredients}"
                puts "#{recipe.description}"
                puts "#{recipe.rating}\n\n"
            end
        else
            puts "Uh-oh looks like you haven't tried any recipes you silly goose!"
        end
    end

    def update_my_recipe_rating
        if self.recipes.count >= 1
        count = 1
        self.recipes.each do |recipe| 
            puts "#{count} #{recipe.name}"
            count +=1
        end
        record = pick_my_recipes
        create_or_update_rating(record)

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


        else
        puts "Uh-oh looks like you haven't tried any recipes you silly goose!"
        end
    end
end
 
