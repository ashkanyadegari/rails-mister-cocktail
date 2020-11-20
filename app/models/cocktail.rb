class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  # When you delete a cocktail, you should delete associated doses (but not the ingredients as they can be linked to other cocktails).
  has_many :ingredients, through: :doses
  has_many :reviews
  validates :name, presence: true, uniqueness: true
  has_one_attached :photo

end
