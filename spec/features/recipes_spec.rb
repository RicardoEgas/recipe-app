# spec/system/recipes_spec.rb

require 'rails_helper'

RSpec.describe 'Recipe page', type: :system do
  before do
    # Create a user
    @user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password')

    # Create recipes associated with the user
    @recipe1 = Recipe.create(name: 'Recipe 1', description: 'Description 1', preparation_time: 0, cooking_time: 0,
                             user: @user)
    @recipe2 = Recipe.create(name: 'Recipe 2', description: 'Description 2', preparation_time: 0, cooking_time: 0,
                             user: @user)

    visit '/users/sign_up'
    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
  end

  it 'displays the list of recipes' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    visit recipes_path
    expect(page).to have_content('Recipe 1', wait: 5)
    expect(page).to have_content('Description 1')
    expect(page).to have_content('Recipe 2')
    expect(page).to have_content('Description 2')
  end

  it 'allows deleting a recipe' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    # Ensure the login is successful before proceeding
    expect(page).to have_content('Signed in successfully.')

    # Explicitly visit recipes_path to handle any redirects
    visit recipes_path

    # Allow some time for the page to render
    expect(page).to have_content('Recipe 1', wait: 5)

    # Check if at least one "Remove" link is present
    expect(page).to have_link('REMOVE')

    # Click the "Remove" link for the first recipe
    click_link('REMOVE', match: :first)

    # Check if the deleted recipe is no longer present
    expect(page).not_to have_content('Recipe 1')
    expect(page).to have_content('Recipe 2')
  end
end
