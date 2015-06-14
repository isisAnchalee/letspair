# == Schema Information
#
# Table name: bids
#
#  id         :integer          not null, primary key
#  project_id :integer          not null
#  price      :integer          not null
#  bidder_id  :integer          not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :bid do
    project_id 1
    price 1
    bidder_id 1
    content "MyText"
  end
end
