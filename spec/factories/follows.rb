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

FactoryGirl.define do
  factory :follow do
    followed_id 0
    followed_type "None"
    follower_id 0
  end
end
