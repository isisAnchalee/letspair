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
end

