require 'faker'

10.times do 
    User.create({name: Faker::Name.name})
end


10.times do 
    temp_ingredients = []
    diets = ["Vegetarian", "Vegan", "Gluten Free", "Keto", "Nut Free", "Dairy Free", "Low Calorie"]
    3.times do 
        temp_ingredients << Faker::Food.ingredient
    end
    joined_ingredients = temp_ingredients.join(", ")
    Recipe.create({
        name: Faker::Food.dish,
        ingredients: joined_ingredients,
        description: Faker::Food.description,
        best_for: diets.sample
        })
end 

30.times do
    Record.create({
        user_id: (rand(5) + 1),
        recipe_id: (rand(5) + 1),
        user_rating: (rand(5) + 1)
    })
end