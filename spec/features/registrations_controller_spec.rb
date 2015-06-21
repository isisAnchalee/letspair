require 'rails_helper'

RSpec.feature "User Registration", :type => :feature do

  scenario 'User signs up with valid credentials' do
    visit '/users/sign_up'
    fill_in 'Username', with: 'dannnnneh', wait: 15
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'passwordpassword'
    fill_in 'Password confirmation', with: 'passwordpassword'
    click_button 'Sign up'
    expect(page).to have_content 'Sign Out', wait: 15
  end

  scenario 'User signs up with invalid credentials' do
    visit '/users/sign_up'
    fill_in 'Username', with: '', wait: 15
    fill_in 'Email', with: 'test@co.m'
    fill_in 'Password', with: 'asswordpassword'
    fill_in 'Password confirmation', with: 'passwordpassword'
    click_button 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match Password", wait: 15
    expect(page).to have_content "Username can't be blank"
  end
end
