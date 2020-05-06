class CommandLineInterface
    attr_accessor :user_name, :you
    def greet
        puts "Welcome to The Recipe Repo!\nPlease enter your name in order to log in or create your account."
        @user_name = gets.chomp
        @you = User.find_or_create_by(name: @user_name)
    end

    def welcome
        puts "Welcome #{@user_name}! \n"
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
        8 - Exit the application"
        reply = gets.chomp
        menu_functions(reply)
    end

    def menu_functions(reply)
        case reply
        when "1"
            #create a recipe
            self.create_recipe
            self.menu
        when "2"
            # self.recipe_search_menu
            temp = Recipe.list_all_recipes
            @you.recipes << temp
            self.menu
        when "3"
            #gives random recipe
            self.random_recipe
            self.menu
        when "4"
            # Rate a recipe 
            @you.update_my_recipe_rating
            self.menu
        when "5"
            # update a rating
            @you.update_my_recipe_rating
            self.menu     
        when "6"
            #delete a rating
            @you.delete_my_recipe_rating
            self.menu
        when "7"
            @you.list_recipes
            self.menu
        when "8"
            puts "Thank you. Hope to see you again!"
        else
            self.error
        end
    end

    # def recipe_search_menu
    #     puts "How would you like to search for a recipe?"
    #     puts "
    #     1. "
    # end

    def error
        puts "That was an invalid entry."
        puts "Please enter a valid number (1 through 6)"
        self.menu
    end

    def random_recipe
        puts "So you're feeling lucky, huh?"
        random = Recipe.all.sample 
        @you.recipes << random
        puts "#{random.name}"
        puts "#{random.ingredients}"
        puts "#{random.description}"
        puts "#{random.rating}"
    end

    def create_recipe
        puts "Let's create a new recipe! What is your recipe called?"
        recipe_name = gets.chomp
        puts "What are the ingredients for #{recipe_name}?"
        recipe_ingredients = gets.chomp
            # STRETCH GOAL - POLISH the way we take, store, and display recipe ingredients
        puts "Wow, what is the descripton??"
        recipe_description = gets.chomp
        Recipe.create({name: recipe_name, ingredients: recipe_ingredients, description: recipe_description})
    end

    def run
        self.greet
        self.welcome
        self.menu
    end
end