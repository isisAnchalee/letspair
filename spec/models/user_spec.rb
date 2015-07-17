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
#  provider               :string
#  uid                    :string
#  name                   :string           not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do
    before { FactoryGirl.create(:user) }
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  context "associations" do
    before { FactoryGirl.create(:user) }
    it { should have_many(:projects).dependent(:destroy) }
    it { should have_many :bids }
  end
  
    it "has many projects" do
      user = FactoryGirl.create(:user)
      project1 = FactoryGirl.create(:project, user_id: user.id)
      project2 = FactoryGirl.create(:project, user_id: user.id)
      expect(user.projects).to eq([project1, project2])
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
