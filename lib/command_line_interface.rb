class CommandLineInterface
    attr_accessor :user_name, :you
    def greet
        puts "Welcome to The Recipie Repo!\nPlease enter your name in order to log in or create your account."
        #then we need to get.chomp or get.strip their name and use it for a User.find_or_creat_by(name: )
        #but where do we write this get.chomp method?
        @user_name = gets.chomp
        @you = User.find_or_create_by(name: @user_name)
    end

    def welcome
        puts "Welcome #{@user_name}! \n"
        sleep(1)
        binding.pry
        puts "You may now search for a recipe, rate a recipe, or contribute your own!\nIf you would like help, type in 'help' at any time."
        sleep (1)
    end

    
    def menu
        puts "
        1 - Create a recipe \n
        2 - Search for recipe \n
        3 - Rate a recipe \n
        4 - Give me a random recipe! \n
        5 - Delete/update a rating \n
        6 - Exit the application \n
        "
        reply = gets.chomp
        menu_functions(reply)
    end
    
    
    def run
        self.greet
        self.welcome
        self.menu
        # self.instructions
    end
    
    private

    def menu_functions(reply)
        case reply
        when "1"
            puts "Let's create a new recipe! What is your recipe called?"
            recipe_name = gets.chomp
            puts "What are the ingredients for #{recipe_name}?"
            recipe_ingredients = gets.chomp
            # STRETCH GOAL - POLISH the way we take, store, and display recipe ingredients
            puts "Wow, what is the descripton?"
            recipe_description = gets.chomp
            Recipe.create({name: recipe_name, ingredients: recipe_ingredients, description: recipe_description})
        
        when "2"
            
        when "3"
        
        when "4"
        
        when "5"
        
        when "6"
            "Thank you. Hope to see you again!"
        
        else
            self.error
        end
    end

    def error
        puts "That was an invalid entry."
        puts "Please enter a valid number (1 through 6)"
        self.menu
    end
end