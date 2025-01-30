class Sauce < ApplicationRecord
    validates :nom, presence: true, format: { with: /\A(?!\d+\z).+/ }
    validates :quantite, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :prix, presence: true, numericality: { greater_than: 0 }
    validates :description, presence: true, length: { maximum: 1000 }
    validates :ingredients, presence: true, length: { maximum: 100 }
    validates :caracteristique, presence: true, length: { maximum: 500 }
end