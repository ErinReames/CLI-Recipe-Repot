class RemoveRatingFromRecipe < ActiveRecord::Migration[4.2]
    def change
        remove_column :recipes, :rating
    end
end