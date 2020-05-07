class CommandLineInterface
    attr_accessor :you

    def greet
        puts "\n"
        puts "Welcome to The Recipe Repo!"
        puts "\n"
        sleep (1)
        puts "Please enter your name in order to log in or create your account."
        puts "\n"
        user_name = gets.chomp
        puts "\n"
        if User.find_by(name: user_name) != nil
            puts "Welcome back #{user_name}!"
        else
            puts "Welcome #{user_name}!"
        end
        @you = User.find_or_create_by(name: user_name)
        sleep(1)
        puts "\n"
        puts "You may now search for a recipe, rate a recipe, or contribute your own!"
        sleep (1.3)
    end

    def menu
        puts "
        1 - Create a recipe \n
        2 - Search for recipe \n
        3 - Give me a random recipe! \n
        4 - Rate a recipe \n
        5 - Update a rating \n
        6 - Delete a rating \n
        7 - List My Recipies \n
        8 - Exit the application\n\n
        Please enter the number for the option you wish to select."
        puts "\n"
        reply = gets.chomp
        puts "\n"
        menu_functions(reply)
    end

    def menu_functions(reply)
        case reply
        when "1"
            self.create_recipe
        when "2"
            self.recipe_search_menu
        when "3"
            self.random_recipe
        when "4"
            @you.update_or_delete__my_recipe_rating("update")
        when "5"
            @you.update_or_delete__my_recipe_rating("update")   
        when "6"
            @you.update_or_delete__my_recipe_rating("delete")
        when "7"
            @you.list_recipes
        when "8"
            puts "Thank you. Hope to see you again!\n"
            return nil
        else
            self.error
        end
        puts "\n"
        sleep (1)
        menu
    end

    def error
        puts "\n"
        puts "That was an invalid entry."
        puts "\n"
        sleep (1)
        puts "You will now be returned to the menu screen"
    end

    def random_recipe
        puts "So you're feeling lucky, huh?"
        puts "\n"
        random = Recipe.all.sample 
        sleep (1)
        puts "Here's your recipe!"
        puts "\n"
        @you.recipes << random
        puts "#{random.name}"
        sleep (1)
        puts "#{random.ingredients}"
        sleep (1)
        puts "#{random.description}"
        sleep(1)
        puts "This recipe is best for people with a #{random.best_for} diet"
        sleep(1)
        if random.average > 0
            puts "and the average rating for this recipe is #{random.average} out of 5 stars!"
        else
            puts "This recipe hasn't been rated yet!"
        end
        puts "\n"
        sleep (1)
        puts "Come back and rate it once you try it out!"
    end

    def create_recipe
        puts "Let's create a new recipe! What is your recipe called?\n"
        recipe_name = gets.chomp
        puts "\nWhat are the ingredients for #{recipe_name}?\n"
        recipe_ingredients = gets.chomp
        puts "\nWow, what is the descripton?\n"
        recipe_description = gets.chomp
        puts "\n"
        puts "Okay, almost there.\n"
        diet = best_for_picker
        Recipe.create({name: recipe_name, ingredients: recipe_ingredients, description: recipe_description, best_for: diet})
        sleep (1)
        puts "\nYou did it!"
        puts "\n"
        sleep (1)
        puts "Your recipe is now published for everyone to see!\n"
    end

    def the_diets
        ["Vegetarian", "Vegan", "Gluten Free", "Keto", "Nut Free", "Dairy Free", "Low Calorie", "Unrestricted"]
    end

    def list_diets
        count = 1
        the_diets.each do |diet| 
            puts "#{count} #{diet}"
            count +=1
        end
        puts "\n"
    end

    def best_for_picker
        puts "Is there a diet this recipe is best for?\nIf not, hit any other key and we will set it to 'Unrestricted'"
        puts "\n"
        list_diets
        response = gets.chomp.to_i 
        if the_diets[response - 1]
            the_diets[response - 1]
        else 
            puts "\nSet to 'Unrestrcted'"
            return "Unrestricted"
        end
    end

    def recipe_search_menu
        puts "How would you like to search for recipes?\n\n1. List them all!\n\n2. List those above a rating!\n\n3. List those of a certain diet!"
        reply = gets.chomp
        puts "\n"
        case reply
        when "1"
            temp = Recipe.list_all_recipes
        when "2"
            temp = by_rating_helper
        when "3"
            temp = by_diet_helper
        end
        if temp
            @you.recipes << temp
        end
    end

    def by_rating_helper
        puts "What is the minimum rating you wish to see? (On a scale of 1 to 5)\n"
        new_reply = gets.chomp.to_i
        if new_reply > 0 && new_reply < 6
            Recipe.list_rated_recipes(new_reply)
        else
            self.error
            nil
        end
    end

    def by_diet_helper
        puts "Which diet would you like to search by?\n"
        list_diets
        new_reply = gets.chomp.to_i
        if new_reply > 0 && new_reply < the_diets.count
            response = Recipe.list_by_diet(the_diets[new_reply - 1])
            if response.class == String
                nil
            end
        else
            self.error
            nil
        end
    end

    def run
        self.greet
        self.menu
    end
end