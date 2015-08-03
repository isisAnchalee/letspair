# == Schema Information
#
# Table name: follows
#
#  id            :integer          not null, primary key
#  followed_id   :integer          not null
#  followed_type :string           not null
#  follower_id   :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#


require 'rails_helper'

RSpec.describe Follow, type: :model do

  context "validations" do
    before { FactoryGirl.create(:follow) }
    it { should validate_presence_of :followed_id }
    it { should validate_presence_of :followed_type }
    it { should validate_presence_of :follower_id }
    it { should validate_uniqueness_of(:follower_id).scoped_to(:followed_id, :followed_type) }
  end

  context "associations" do
    before { FactoryGirl.create(:follow) }
    it { should belong_to :follower }
    it { should belong_to :followed }
  end
end

