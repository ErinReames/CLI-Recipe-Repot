class CommandLineInterface
    attr_accessor :user_name, :you
    def greet
        puts "\n\nWelcome to The Recipe Repo! \n"
        sleep (1)
        puts "Please enter your name in order to log in or create your account.\n"
        @user_name = gets.chomp
        if User.find_by(name: @user_name) != nil
            puts "Welcome back #{@user_name}!\n"
        else
            puts "Welcome #{@user_name}! \n"
        end
        @you = User.find_or_create_by(name: @user_name)
        sleep(1)
        puts "You may now search for a recipe, rate a recipe, or contribute your own!"
        sleep (1)
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
        8 - Exit the application\n"
        reply = gets.chomp
        menu_functions(reply)
    end

    def menu_functions(reply)
        case reply
        when "1"
            self.create_recipe
        when "2"
            temp = self.recipe_search_menu
            if temp
                @you.recipes << temp
            end
        when "3"
            self.random_recipe
        when "4"
            @you.update_my_recipe_rating
        when "5"
            @you.update_my_recipe_rating   
        when "6"
            @you.delete_my_recipe_rating
        when "7"
            @you.list_recipes
        when "8"
            puts "Thank you. Hope to see you again!"
            return "Goodbye."
        else
            self.error
        end
        sleep (1.3)
        menu
    end

    def recipe_search_menu
        puts "Would you like to see all recipes or ony those above a certain rating?\n1. List all\n2. Of a certain Rating"
        reply = gets.chomp
        case reply
        when "1"
            temp = Recipe.list_all_recipes
        when "2"
            puts "What is the minimum rating you wish to see? (On a scale of 1 to 5)"
            new_reply = gets.chomp
            if new_reply.to_i > 0 && new_reply.to_i < 6
                temp = Recipe.list_rated_recipes(new_reply.to_i)
            else
                self.error
                temp = nil
            end
        end
        temp 
    end

    def error
        puts "That was an invalid entry."
        sleep (1)
        puts "You will now be returned to the menu screen"
        sleep (1)
    end

    def random_recipe
        puts "So you're feeling lucky, huh?"
        random = Recipe.all.sample 
        sleep (1)
        puts "Here's your recipe!"
        @you.recipes << random
        puts "#{random.name}"
        sleep (1)
        puts "#{random.ingredients}"
        sleep (1)
        puts "#{random.description}"
        puts "#{random.rating}"
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
        Recipe.create({name: recipe_name, ingredients: recipe_ingredients, description: recipe_description})
        sleep (1)
        puts "\nYou did it!\n"
        puts "Your recipe is now published for everyone to see!\n"
    end

    def run
        self.greet
        self.menu
    end
end