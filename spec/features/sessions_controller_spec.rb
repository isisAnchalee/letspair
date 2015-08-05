require 'rails_helper'

RSpec.feature "Sessions Controller", :type => :feature do

  scenario 'User signs in with email' do
    visit 'users/sign_in'
    user = FactoryGirl.create(:user)
    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Sign Out'
  end

  scenario 'User signs in with invalid email' do
    # Todo: Error messages
    visit 'users/sign_in'
    fill_in 'Login', with: "me@me.com"
    fill_in 'Password', with: "password"
    click_button 'Log in'
    expect(page).to have_content 'Log in'
  end

  scenario 'User signs out' do
    visit 'users/sign_in'
    user = FactoryGirl.create(:user, email: "danneh@danneh.danneh", password: "oneoneone")
    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    click_link 'Sign Out'
    expect(page).to have_content 'Sign In'
  end
end
