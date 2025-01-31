FactoryBot.define do
  factory :sauce do
    nom { "Tomato Sauce" }
    description { "A delicious tomato sauce." }
    ingredients { "Tomatoes, spices" }
    caracteristique { "Spicy" }
    quantite { 500 }
    prix { 3.99 }
  end

  factory :sauce_with_empty_fields, class: 'Sauce' do
    nom { '' }
    description { '' }
    ingredients { '' }
    caracteristique { '' }
    quantite { nil }
    prix { nil }
  end
end
  