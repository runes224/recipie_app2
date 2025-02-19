# frozen_string_literal: true

class Ingredient < ApplicationRecord
  has_many :ingredient_relations, dependent: :destroy, inverse_of: :ingredient
  has_many :recipes, through: :ingredient_relations
  validates :name, presence: true
  validates :group, presence: true
  validates :calorie, presence: true
  validates :carbohydrate, presence: true
  validates :protein, presence: true
  validates :lipid, presence: true
  validates :salt, presence: true

  scope :name_like, -> (name) { where("name LIKE(?)", "%#{name}%") }
end
