class User < ActiveRecord::Base
    has_many :records
    has_many :recipes, through: :records

end