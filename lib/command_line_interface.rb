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
        puts "Welcome #{@user_name}!"
        puts "You may now search for a recipe, rate a recipe, or contribute your own!\nIf you would like help, type in 'help' at any time."
    end

   def menu
        
   end

    def run
        self.greet
        self.welcome
        self.instructions
    end
end