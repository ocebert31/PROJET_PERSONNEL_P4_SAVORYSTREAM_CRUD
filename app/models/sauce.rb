class Sauce < ApplicationRecord
  validates :nom, presence: true, format: { with: /\A(?!\d+\z).+/ }
  validates :quantite, presence: true
  validates :prix, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :caracteristique, presence: true, length: { maximum: 500 }
  validate :validate_quantite
  validate :validate_ingredients

  private

  def validate_quantite
    validate_array_of_strings(:quantite, 100)
  end

  def validate_ingredients
    validate_array_of_strings(:ingredients, 100)
  end  

  def validate_array_of_strings(attribute, max_length)
    value = send(attribute)
    return unless value.is_a?(Array)

    if value.empty?
      errors.add(attribute, "ne peut pas être vide")
      return
    end

    value.each do |item|
      if !item.is_a?(String) || item.strip.empty?
        errors.add(attribute, "#{attribute.to_s.humanize} doit contenir uniquement des chaînes non vides")
      end

      if item.length > max_length
        errors.add(attribute, "Chaque élément de #{attribute.to_s.humanize.downcase} ne doit pas dépasser #{max_length} caractères")
      end
    end
  end
end
