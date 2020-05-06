require 'faker'

5.times do 
    User.create({name: Faker::Name.name})
end


10.times do 
    temp_ingredients = []
    3.times do 
        temp_ingredients << Faker::Food.ingredient
    end
    joined_ingredients = temp_ingredients.join(", ")
    Recipe.create({
        name: Faker::Food.dish,
        ingredients: joined_ingredients,
        description: Faker::Food.description,
        rating: nil
        })
end 

20.times do
    Record.create({
        user_id: (rand(5) + 1),
        recipe_id: (rand(5) + 1),
        user_rating: (rand(5) + 1)
    })
end