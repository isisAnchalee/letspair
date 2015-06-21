# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string           not null
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
#

require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do

    it "properly validates a correct user" do
      user = User.new(username: "Danny", email: "danny@danny.com", password: "dannydanny")
      expect(user).to be_valid
    end

    it "properly validates an incorrect user" do
      user = User.new(username: "d", email: "d", password: "d")
      expect(user).to_not be_valid
    end
  end

  context "associations" do

    it "has many projects" do
      user = FactoryGirl.create(:user)
      project1 = FactoryGirl.create(:project, user_id: user.id)
      project2 = FactoryGirl.create(:project, user_id: user.id)
      expect(user.projects).to eq([project1, project2])
    end

    it "destroyes projects when user is deleted" do
      user = FactoryGirl.create(:user)
      project1 = FactoryGirl.create(:project, user_id: user.id)
      project2 = FactoryGirl.create(:project, user_id: user.id)
      expect(user.projects).to eq([project1, project2])
      expect(Project.all.count).to eq(2)
      user.destroy
      expect(Project.all.count).to eq(0)
    end

    it "has many bids" do
      user = FactoryGirl.create(:user)
      bid1 = FactoryGirl.create(:bid, bidder_id: user.id)
      bid2 = FactoryGirl.create(:bid, bidder_id: user.id)
      expect(user.bids).to eq([bid1, bid2])
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
