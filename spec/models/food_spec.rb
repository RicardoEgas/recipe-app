require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:each) do
    @user = User.create(name: 'User', email: 'example@gmail.com', password: '123456', password_confirmation: '123456')
    @food = Food.create(name: 'Food', measurement_unit: 'kg', price: 10, quantity: 1, user: @user)
  end

  describe 'validations' do
    it 'should be valid with valid attributes' do
      expect(@food).to be_a(Food)
      expect(@food).to be_valid
    end

    it 'is valid with a name' do
      @food.name = 'Food'
      expect(@food).to be_valid
    end

    it 'is not valid without a user' do
      @food.user = nil
      expect(@food).to_not be_valid
    end

    it 'is not valid without a measurement unit' do
      @food.measurement_unit = nil
      expect(@food).to_not be_valid
    end

    it 'is not valid with a long name' do
      @food.name = 'a' * 101
      expect(@food).to_not be_valid
    end

    it 'is not valid with a long measurement unit' do
      @food.measurement_unit = 'a' * 21
      expect(@food).to_not be_valid
    end

    it 'is not valid with a negative price' do
      @food.price = -5
      expect(@food).to_not be_valid
    end

    it 'is not valid with a negative quantity' do
      @food.quantity = -1
      expect(@food).to_not be_valid
    end
  end
end
