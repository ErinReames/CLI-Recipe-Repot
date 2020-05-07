#class for the recipe database we are pulling from
class Recipe < ActiveRecord::Base
    has_many :records 
    has_many :users, through: :records
    # attr_accessor :new_array, :average_rating

    # self.recipes.average(:rating)

    def self.every_average
        array = all.map do |recipe|
           [recipe.id, recipe.records.average(:user_rating).round]
        end
        hash = Hash[array.map {|key, value| [key, value]}]
        hash
    end

    def average
        records.average(:user_rating).round
    end
    
    # def self.above_rating(rating)
    #     assign_ratings
    #     # all.select {|recipe| recipe.rating.class == Integer && recipe.rating >= rating.to_i}
    #     all.select {|recipe| recipe.average_rating.class == Integer && recipe.average_rating >= rating.to_i}
    # end
    
    # def self.assign_ratings
    #     all.select{|recipe| recipe.avg_rating_method}
    # end

    # def show_rating
    #     self.avg_rating_method
    #     if self.rating.class == Integer
    #         # self.rating
    #         self.average_rating
    #     else
    #         puts "This recipe has not been rated yet."
    #     end
    # end

    # def avg_rating_method
    #     ratings_array = self.records.map{|r|r.user_rating}.compact
    #     if ratings_array.count > 0
    #         new_rating = ratings_array.inject{|sum,v|sum+v}/(ratings_array.count)
    #         # self.update(rating: new_rating)
    #         self.average_rating = new_rating
    #     else
    #         average_rating = nil
    #     end
    # end

    def self.list_all_recipes
        count = 1
        puts "\n"
        Recipe.all.each do |recipe| 
            puts "#{count} #{recipe.name}\n "
            count +=1
        end
        puts "Enter the number for the recipe you'd like to add."
        select_recipe(all)
    end

    def self.list_rated_recipes(min)
        count = 1
        puts "\n"
        array = all.select {|recipe| recipe.average >= min}
        array.each do |recipe|
            puts "#{count} #{recipe.name}\n "
            count +=1
        end
        select_recipe(array)
    end

    def self.select_recipe(array)
        puts "Enter the number for the recipe you'd like to add."
        response = gets.chomp.to_i
        if response && response  <= array.count
            puts "Added!"
            sleep (1)
            puts "Come back and rate it once you try it out!"
            sleep (1)
            array[(response - 1)]
        else
            puts "Sorry, that is an invalid input."
            sleep (1)
            puts "We will now return you to the menu"
            sleep (1)
            nil
        end
    end

end