require 'rails_helper'

RSpec.describe Sauce, type: :model do
 let(:valid_sauce) { Sauce.new(nom: 'Sauce tomate', quantite: ['500ml', '1L'], prix: 3.99, description: 'Delicious tomato sauce', ingredients: ['Tomatoes', 'Salt'], caracteristique: 'Spicy') }

  describe 'Validations' do
    context 'when field for sauce is valid' do
        it 'with all good field' do
            expect(valid_sauce).to be_valid
        end
    end
 
    context 'when field for sauce is invalid' do
        it 'without a name' do
            valid_sauce.nom = nil
            expect(valid_sauce).to_not be_valid
        end

        it 'with a number name' do
            valid_sauce.nom = 12
            expect(valid_sauce).to_not be_valid
        end

        it 'with any quantity' do
            valid_sauce.quantite = []
            expect(valid_sauce).to_not be_valid
        end

        it 'is invalid with quantity longer than 100 characters' do
            valid_sauce.quantite = ['100ml' * 101, '1L']
            expect(valid_sauce).to_not be_valid
        end

        it 'without a price' do
            valid_sauce.prix = nil
            expect(valid_sauce).to_not be_valid
        end

        it 'with a price less than or equal to zero' do
            valid_sauce.prix = -1
            expect(valid_sauce).to_not be_valid
        end

        it 'with a non-integer price' do
            valid_sauce.prix = 'cinq'
            expect(valid_sauce).to_not be_valid
        end
    
        it 'without a description' do
            valid_sauce.description = nil
            expect(valid_sauce).to_not be_valid
        end

        it 'is invalid with a description longer than 1000 characters' do
            valid_sauce.description = 'a' * 1001
            expect(valid_sauce).to_not be_valid
        end

        it 'is invalid with ingredients longer than 100 characters' do
            valid_sauce.ingredients = ['a' * 101, 'Salt']
            expect(valid_sauce).to_not be_valid
        end

        it 'is invalid without ingredients' do
            valid_sauce.ingredients = []
            expect(valid_sauce).to_not be_valid
        end

        it 'without the features' do
            valid_sauce.caracteristique = nil
            expect(valid_sauce).to_not be_valid
        end

        it 'is invalid with features longer than 500 characters' do
            valid_sauce.caracteristique = 'a' * 501
            expect(valid_sauce).to_not be_valid
        end
    end
  end
end
