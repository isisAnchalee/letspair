# Table name: projects
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  complexity  :integer
#  price       :integer


FactoryGirl.define do
  factory :project do
    title "Project Title"
    description "This is a description"
    complexity 10
    price 10
    user_id 1
  end
end