class Review < ApplicationRecord
  belongs_to :cocktail
  has_one_attached :photo
  validates :rating, inclusion: { in: (0..5).to_a }

end
