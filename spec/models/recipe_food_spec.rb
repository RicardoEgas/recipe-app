# spec/models/recipe_food_spec.rb

require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before(:each) do
    @user = User.create(name: 'User', email: 'example@gmail.com', password: '123456', password_confirmation: '123456')
    @recipe = Recipe.create(name: 'Recipe', user: @user, preparation_time: 0, cooking_time: 0)
    @food = Food.create(name: 'Food', measurement_unit: 'kg', price: 10, quantity: 1, user: @user)
    @recipe_food = RecipeFood.create(recipe: @recipe, food: @food, quantity: 2)
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(@recipe_food).to be_a(RecipeFood)
      expect(@recipe_food).to be_valid
    end

    it 'is not valid without a quantity' do
      @recipe_food.quantity = nil
      expect(@recipe_food).to_not be_valid
    end

    it 'is not valid with a negative quantity' do
      @recipe_food.quantity = -1
      expect(@recipe_food).to_not be_valid
    end

    it 'is not valid with a non-integer quantity' do
      @recipe_food.quantity = 1.5
      expect(@recipe_food).to_not be_valid
    end
  end
end
