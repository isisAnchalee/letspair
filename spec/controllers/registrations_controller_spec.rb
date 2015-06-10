require 'rails_helper'

describe "Users::RegistrationsController" do
  describe "#new" do
    it "should create a new user" do
      # debugger
      get new_user_registration_path
      debugger
      expect(page).to have_selector "h2"
    end
  end
end