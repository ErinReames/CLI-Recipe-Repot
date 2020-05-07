require 'faker'

10.times do 
    User.create({name: Faker::Name.name})
end

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

30.times do
    Record.create({
        user_id: (rand(5) + 1),
        recipe_id: (rand(5) + 1),
        user_rating: (rand(5) + 1)
    })
end