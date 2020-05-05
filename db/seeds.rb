require 'faker'

5.times do 
    User.create({name: Faker::Name.name})
end

5.times do 
Recipe.create({name: Faker::Food.dish})
end 
