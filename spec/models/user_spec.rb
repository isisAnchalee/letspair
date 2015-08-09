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

class Auth
  attr_accessor :uid, :provider, :info

  class Info
    attr_accessor :email, :verified, :verified_email, :first_name, :last_name
  end

  def initialize
    self.info = Info.new
  end
end

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
    it { should have_many(:identities).dependent(:destroy) }
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
    it "#find_for_auth can find a user through an identity" do
      user = FactoryGirl.create(:user)
      auth = Auth.new
      auth.uid = 5
      auth.provider = "me"
      FactoryGirl.create(:identity, user_id: user.id, uid: auth.uid, provider: auth.provider)

      expect(User.find_for_oauth(auth)).to eq(user)
    end

    it "#find_for_auth can create an identity for a user" do
      user = FactoryGirl.create(:user, email: "me@me.com")
      auth = Auth.new
      auth.uid = 5
      auth.provider = "me"
      auth.info.email = "me@me.com"
      auth.info.verified = true
      auth.info.verified_email = true

      expect(User.find_for_oauth(auth)).to eq(user)
    end

    it "#find_for_auth creates a user" do
      auth = Auth.new
      auth.uid = 5
      auth.provider = "me"
      auth.info.email = "me@me.com"
      auth.info.verified = true
      auth.info.verified_email = true
      auth.info.first_name = "danny"
      auth.info.last_name = "bz"

      expect(User.all.count).to eq(0)
      User.find_for_oauth(auth)
      expect(User.all.count).to eq(1)
    end

    it "#email_verified? returns true for email addresses" do
      user = FactoryGirl.create(:user, email: "me@me.mememe")
      expect(user.email_verified?).to eq(true)
    end
  end
end
