FactoryBot.define do
  factory :sauce do
    nom { "Tomato Sauce" }
    description { "A delicious tomato sauce." }
    ingredients { ["Tomatoes, spices"] }
    caracteristique { "Spicy" }
    quantite { ["500ml", "1L"] }
    prix { 3.99 }
  end

  factory :sauce_with_empty_fields, class: 'Sauce' do
    nom { '' }
    description { '' }
    ingredients { [] }
    caracteristique { '' }
    quantite { [] }
    prix { nil }
  end
end
  