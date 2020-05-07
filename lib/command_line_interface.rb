
class CommandLineInterface
    attr_accessor :you
    def greet 
        puts Rainbow("
         /$$$$$$$                      /$$                           /$$$$$$$                                  /$$    
        | $$__  $$                    |__/                          | $$__  $$                                | $$    
        | $$  | $$  /$$$$$$   /$$$$$$$ /$$  /$$$$$$   /$$$$$$       | $$  | $$  /$$$$$$   /$$$$$$   /$$$$$$  /$$$$$$  
        | $$$$$$$/ /$$__  $$ /$$_____/| $$ /$$__  $$ /$$__  $$      | $$$$$$$/ /$$__  $$ /$$__  $$ /$$__  $$|_  $$_/  
        | $$__  $$| $$$$$$$$| $$      | $$| $$  | $$| $$$$$$$$      | $$__  $$| $$$$$$$$| $$  | $$| $$  | $$  | $$    
        | $$  | $$| $$_____/| $$      | $$| $$  | $$| $$_____/      | $$  | $$| $$_____/| $$  | $$| $$  | $$  | $$ /$$
        | $$  | $$|  $$$$$$$|  $$$$$$$| $$| $$$$$$$/|  $$$$$$$      | $$  | $$|  $$$$$$$| $$$$$$$/|  $$$$$$/  |  $$$$/
        |__/  |__/ |_______/ |_______/|__/| $$____/  |_______/      |__/  |__/ |_______/| $$____/  |______/    |___/  
                                          | $$                                          | $$                          
                                          | $$                                          | $$                          
                                          |__/                                          |__/                          


        ").red 
        puts "\n"
        puts Rainbow("Welcome to The Recipe Repot!").bright.red 
        puts "\n"
        sleep (1)
        puts Rainbow("Please enter your name in order to log in or create your account.").bright.red
        puts "\n"
        user_name = gets.chomp
        puts "\n"
        if User.find_by(name: user_name) != nil
            puts Rainbow("Welcome back #{user_name}!").bright.red 
        else
            puts Rainbow("Welcome #{user_name}!").bright.red 
        end
        @you = User.find_or_create_by(name: user_name)
        sleep(1)
        puts "\n"
        puts Rainbow("You may now search for a recipe, rate a recipe, or contribute your own!").bright.red 
        sleep (1.3)
    end

    def menu
        puts Rainbow("
        1 - Create a recipe \n
        2 - Search for recipe \n
        3 - Give me a random recipe! \n
        4 - Rate a recipe \n
        5 - Update a rating \n
        6 - Delete a rating \n
        7 - List My Recipes \n
        8 - Exit the application\n\n
        Please enter the number for the option you wish to select.").bright.red 
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
            puts Rainbow("Thank you. Hope to see you again!\n").bright.red 
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
        puts Rainbow("That was an invalid entry.").bright.red.underline
        puts "\n"
        sleep (1)
        puts Rainbow("You will now be returned to the menu screen").bright.underline.red 
    end

    def random_recipe
        random = Recipe.all.sample
        while @you.recipes.include?(random) do
            random = Recipe.all.sample
            if @you.recipes.uniq.count == Recipe.all.count
                puts Rainbow("WOW! you already have checkout out all our recipes! \n ").bright.red
                sleep (1)
                puts Rainbow("You will now be returned to the menu screen").bright.underline.red 
                return nil
            end
        end
        puts Rainbow("So you're feeling lucky, huh?").bright.red.italic
        puts "\n"
        sleep (1)
        puts Rainbow("Here's your recipe!").bright.red 
        puts "\n"
        @you.recipes << random
        puts Rainbow("Name: #{random.name}").bright.red 
        sleep (1)
        puts Rainbow("Ingredients: #{random.ingredients}").bright.red 
        sleep (1)
        puts Rainbow("Description: #{random.description}").bright.red 
        sleep(1)
        puts Rainbow("\nThis recipe is best for people with #{random.best_for} diets").bright.red 
        sleep(1)
        if random.average > 0
            puts Rainbow("The average rating for this recipe is #{random.average} out of 5 stars!").bright.red 
        else
            puts Rainbow("This recipe hasn't been rated yet!").red.bright
        end
        sleep (1)
        puts "\n"
        puts Rainbow("Come back and rate it once you try it out!").bright.red 
    end

    def create_recipe
        puts Rainbow("Let's create a new recipe! What is your recipe called?\n").red.bright
        recipe_name = gets.chomp
        puts Rainbow("\nWhat are the ingredients for #{recipe_name}?\n").red.bright
        recipe_ingredients = gets.chomp
        puts Rainbow("\nWow, what is the descripton?\n").red.bright 
        recipe_description = gets.chomp
        puts "\n"
        puts Rainbow("Okay, almost there.").red.bright
        sleep (1)
        puts "\n"
        diet = best_for_picker
        Recipe.create({name: recipe_name, ingredients: recipe_ingredients, description: recipe_description, best_for: diet})
        sleep (1)
        puts Rainbow("\nYou did it!").red.bright
        puts "\n"
        sleep (1)
        puts Rainbow("Your recipe is now published for everyone to see!\n").red.bright
    end

    def the_diets
        ["Vegetarian", "Vegan", "Gluten Free", "Keto", "Nut Free", "Dairy Free", "Low Calorie", "Unrestricted"]
    end

    def list_diets
        count = 1
        the_diets.each do |diet| 
            puts Rainbow("#{count} - #{diet} \n ").bright.red
            count +=1
        end
    end

    def best_for_picker
        puts Rainbow("Is there a diet this recipe is best for?\nIf not, hit any other key and we will set it to 'Unrestricted'").red.bright
        sleep (1)
        puts "\n"
        list_diets
        response = gets.chomp.to_i 
        if the_diets[response - 1]
            the_diets[response - 1]
        else 
            puts Rainbow("\nSet to 'Unrestrcted'").bright.red 
            return Rainbow("Unrestricted").bright.red 
        end
    end

    def recipe_search_menu
        if @you.recipes.uniq.count == Recipe.all.count
            puts Rainbow("WOW! you already have checkout out all our recipes! \n ").bright.red
            sleep (0.7)
            puts Rainbow("Come back another time and see if there are more recipes avalible, or contribute your own!").bright.red
            return nil
        end
        puts Rainbow("How would you like to search for recipes?\n\n1. List them all!\n\n2. List those above a rating!\n\n3. List those of a certain diet!\n").bright.red 
        reply = gets.chomp
        puts "\n"
        case reply
        when "1"
            temp = Recipe.list_all_recipes
        when "2"
            temp = by_rating_helper
        when "3"
            temp = by_diet_helper
        else
            self.error
        end
        if temp
            @you.recipes << temp
        end
    end

    def by_rating_helper
        puts Rainbow("What is the minimum rating you wish to see? (On a scale of 1 to 5)\n").bright.red 
        new_reply = gets.chomp.to_i
        if new_reply > 0 && new_reply < 6
            Recipe.list_rated_recipes(new_reply)
        else
            self.error
            nil
        end
    end

    def by_diet_helper
        puts Rainbow("Which diet would you like to search by?\n").red.bright
        puts "\n"
        list_diets
        new_reply = gets.chomp.to_i
        if new_reply > 0 && the_diets[new_reply - 1]
            response = Recipe.list_by_diet(the_diets[new_reply - 1])
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