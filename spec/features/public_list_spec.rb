require 'rails_helper'

RSpec.describe 'Public Recipes List page', type: :system do
  before do
    @user = User.create(name: 'Ben White', email: 'ben@example.com', password: 'password')
    @recipe = Recipe.create(name: 'My Recipe', description: 'My Description', preparation_time: 0, cooking_time: 0,
                            user: @user)

    visit '/users/sign_up'
    fill_in 'Name', with: 'Ben White'
    fill_in 'Email', with: 'ben@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
  end

  it 'displays the list of public recipes' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'ben@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    # Ensure the login is successful before proceeding
    expect(page).to have_content('Signed in successfully.')

    # Visit the recipes path
    visit recipes_path

    # Click the link to the recipe
    click_link 'My Recipe'

    # Find the button to Make it public and click it
    click_button 'Make Public'

    # Visit the public recipes list page
    visit public_recipes_path

    # Allow some time for the page to render
    expect(page).to have_content('Public Recipes', wait: 5)

    # Check if the list of public recipes is displayed
    expect(page).to have_content('My Recipe')
    expect(page).to have_content('Total price: $0')
  end
end
