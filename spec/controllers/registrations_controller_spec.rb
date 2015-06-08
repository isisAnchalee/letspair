require 'rails_helper'

describe "Users::RegistrationsController" do
  describe "#new" do
    it "should create a new user" do
      # debugger
      visit "/users/sign_up"
      expect(page).to have_selector "h2"
    end
  end
end