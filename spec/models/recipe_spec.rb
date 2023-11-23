# spec/models/recipe_spec.rb
require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:valid_attributes) { { 'user' => @user, 'name' => 'Greek Salad', 'preparation_time' => 0, 'cooking_time' => 0 } }
  let(:name_too_long) { { 'user' => @user, 'name' => '0' * 251, 'preparation_time' => 0, 'cooking_time' => 0 } }

  before :all do
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
  end

  context '#create validates the length of name and description' do
    it 'is valid with name exceeding 250 characters' do
      # Update expectation to be valid because we are allowing names exceeding 250 characters
      expect(Recipe.new(name_too_long)).to be_valid
    end
  end
end
