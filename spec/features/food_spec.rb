require 'rails_helper'

RSpec.describe 'Food page', type: :system do
  before do
    @user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
    @food1 = Food.create(name: 'Food 1', measurement_unit: 'kg', price: 10, quantity: 1, user: @user)
    @food2 = Food.create(name: 'Food 2', measurement_unit: 'unit', price: 5, quantity: 2, user: @user)

    # Visit the registration page and create a user
    visit '/users/sign_up'
    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
  end

  it 'displays the list of foods' do
    visit foods_path
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    # Check if the table headers are present
    expect(page).to have_content('Name')
    expect(page).to have_content('Measurement Unit')
    expect(page).to have_content('Price')
    expect(page).to have_content('Action')

    # Check if the foods are displayed in the table
    expect(page).to have_content('Food 1')
    expect(page).to have_content('kg')
    expect(page).to have_content('10')

    expect(page).to have_content('Food 2')
    expect(page).to have_content('unit')
    expect(page).to have_content('5')
  end

  it 'allows deleting a food item' do
    visit foods_path
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    # Check if the Delete button is present
    expect(page).to have_button('Delete', count: 2)

    # Click the Delete button for the first food item
    first("input[type='submit'][value='Delete']").click

    # Check if the deleted food item is no longer present
    expect(page).not_to have_content('Food 1')
    expect(page).to have_content('Food 2')
  end
end
