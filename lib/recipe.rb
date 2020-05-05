#class for the recipe database we are pulling from
class Recipe < ActiveRecord::Base
    has_many :records 
    has_many :users, through: :records

end