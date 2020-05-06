#class for the recipe database we are pulling from
class Recipe < ActiveRecord::Base
    has_many :records 
    has_many :users, through: :records

    
    def avg_rating
        ratings_array = self.records.map{|r|r.user_rating}.compact
        if ratings_array.count > 0
            new_rating = ratings_array.inject{|sum,v|sum+v}/(ratings_array.count)
        self.update(rating: new_rating)
        #self.save
        new_rating
        else 
            puts "This recipe has not been rated yet"
        end
    end

    def self.list_all_recipes
        count = 1
        Recipe.all.each do |recipe| 
            puts "#{count} #{recipe.name}"
            count +=1
        end
        puts "Enter the number for the recipe you'd like to add."
        select_recipe
    end

    def self.select_recipe
        response = gets.chomp
        Recipe.all[(response.to_i - 1)]
    end

end