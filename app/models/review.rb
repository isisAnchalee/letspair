# == Schema Information
#
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

class Review < ActiveRecord::Base
  validates :reviewer_id, :reviewed_id, :project_id, :rating, :title, :body, presence: true
  validates :title, :body, length: { minimum: 2 }

  belongs_to :reviewer, foreign_key: :reviewer_id, class_name: "User"
  belongs_to :reviewed, foreign_key: :reviewed_id, class_name: "User"
  belongs_to :project
  
end
