# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text             not null
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#  complexity  :integer
#  price       :integer
#  time_line   :integer          not null
#

FactoryGirl.define do
  factory :project do
    title "Project Title"
    description "This is a description"
    complexity 10
    price 10
    user_id 1
    time_line 1
  end
end
