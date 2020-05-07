require 'faker'

Recipe.destroy_all

# Seeding user names with Faker
5.times do 
    User.create({name: Faker::Name.name})
end

# Seeding recipes with a combination of API and Faker: name and ingredients are API and descrpition is Faker
# Change any ingredients in this array to change what kind of recipes get seeded.  Each ingredient provides two recipes, for 10 total
ingredients = ["eggs", "apple", "potato", "chocolate", "chicken"]
count = 0
5.times do
    recipes = PuppyRecipe.get_data(ingredients[count],1)
    recipes.each do |recipe|
        entry = Recipe.new(recipe)
        entry.save
    end
    count +=1
end

# Record instances with recipe ratings
20.times do
    Record.create({
        user_id: (rand(5) + 1),
        recipe_id: (rand(5) + 1),
        user_rating: (rand(5) + 1)
    })
end