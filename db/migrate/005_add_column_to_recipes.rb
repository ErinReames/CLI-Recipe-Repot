class AddColumnToRecipes < ActiveRecord::Migration[4.2]
    def change
        add_column :recipes, :best_for, :string
    end
end