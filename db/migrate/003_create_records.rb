class CreateRecords < ActiveRecord::Migration[4.2]

    def change
        create_table :records do |t|
            t.integer :user_id
            t.integer :recipe_id
            t.integer :user_rating
            
        end

    end
end