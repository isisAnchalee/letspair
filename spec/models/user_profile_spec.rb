# == Schema Information
#
# Table name: user_profiles
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  short_tag_line :string
#  description    :text
#  work_history   :text
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

RSpec.describe UserProfile, type: :model do

  context "validations" do
    before { FactoryGirl.create(:user_profile) }
    it { should validate_presence_of :user_id }
  end

  context "associations" do
    before { FactoryGirl.create(:user_profile) }
    it { should belong_to :user }
  end

  context "methods" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:profile) { FactoryGirl.create(:user_profile, user_id: user.id) }

    it "#first_name" do
      expect(profile.first_name).to eq(user.first_name)
    end

    it "#last_name" do
      expect(profile.last_name).to eq(user.last_name)
    end

    it "#full_name" do
      expect(profile.full_name).to eq("#{user.first_name} #{user.last_name}")
    end

    it "#email" do
      expect(profile.email).to eq(user.email)
    end
  end
end

