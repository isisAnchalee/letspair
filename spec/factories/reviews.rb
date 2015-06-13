# Table name: reviews
#
#  id          :integer          not null, primary key
#  reviewer_id :integer          not null
#  reviewed_id :integer          not null
#  title       :string           not null
#  body        :text             not null
#  rating      :integer          not null
#  project_id  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :review do
    reviewer_id 1
    reviewed_id 1
    title "some title"
    body "some text"
    rating 10
    project_id 1
  end
end
