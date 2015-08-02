# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  admin                  :boolean          default(FALSE)
#  first_name             :string           not null
#  last_name              :string           not null
#  is_company             :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do
    before { FactoryGirl.create(:user) }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  context "associations" do
    before { FactoryGirl.create(:user) }
    it { should have_many(:projects).dependent(:destroy) }
    it { should have_many :bids }
    it { should have_one :user_profile }
    it { should have_one :company_profile }
  end

  context "methods" do
    it "User has a user profile" do
      user = FactoryGirl.create(:user)
      profile = FactoryGirl.create(:user_profile, user_id: user.id)
      expect(user.profile).to eq(profile)
    end

    it "User has a company profile" do
      user = FactoryGirl.create(:user)
      profile = FactoryGirl.create(:company_profile, user_id: user.id)
      expect(user.profile).to eq(profile)
    end
  end

  context "devise" do
    it "can find user by email" do
      user = FactoryGirl.create(:user)
      warden_conditions = { email: user.email.upcase! }
      authenticated = User.find_for_database_authentication(warden_conditions)
      expect(authenticated).to eq user
    end
  end
end
