require 'rails_helper'

RSpec.feature "User Registration", :type => :feature do

  scenario 'User signs up with valid credentials' do
    visit '/users/sign_up'

    expect(current_path).to eq '/users/sign_up'
    puts page.html

    fill_in 'Username', with: 'dannnnneh'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'passwordpassword'
    fill_in 'Password confirmation', with: 'passwordpassword'
    click_button 'Sign up'
    expect(page).to have_content 'Sign Out'
  end

  scenario 'User signs up with invalid credentials' do
    visit '/users/sign_up'
    fill_in 'Username', with: ''
    fill_in 'Email', with: 'test@co.m'
    fill_in 'Password', with: 'asswordpassword'
    fill_in 'Password confirmation', with: 'passwordpassword'
    click_button 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(page).to have_content "Username can't be blank"
  end
end