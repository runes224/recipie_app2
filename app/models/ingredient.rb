class Ingredient < ApplicationRecord
  has_many :recipes, through: :ingredient_relations
end
