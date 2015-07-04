require 'rails_helper'

RSpec.feature "Sessions Controller", :type => :feature do

  scenario 'User signs in with username' do
    visit '/sign-in'
    user = FactoryGirl.create(:user, username: "danneh", password: "oneoneone")
    fill_in 'Login', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_button 'Sign Out'
  end

  scenario 'User signs in with email' do
    visit '/sign-in'
    user = FactoryGirl.create(:user, email: "danneh@danneh.danneh", password: "oneoneone")
    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_button 'Sign Out'
  end

  scenario 'User signs in with invalid email' do
    # Todo: Error messages
    visit '/sign-in'
    fill_in 'Login', with: "me@me.com"
    fill_in 'Password', with: "password"
    click_button 'Log in'
    expect(page).to have_content 'Log in'
  end

  scenario 'User signs out' do
    visit '/sign-in'
    user = FactoryGirl.create(:user, email: "danneh@danneh.danneh", password: "oneoneone")
    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    click_button 'Sign Out'
    expect(page).to have_content 'Sign In'
  end
end
