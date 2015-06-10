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
  validates :reviewer_id, presence: true
  validates :reviewed_id, presence: true
  validates :project_id, presence: true
  validates :rating, presence: true
  validates :title, length: { minimum: 2 }
  validates :body, length: { minimum: 2 }
  
  belongs_to :reviewer, forign_key: :reviewer_id, class_name: "User"
  belongs_to :reviewed, forign_key: :reviewed_id, class_name: "User"
  belogns_to :project
  
end
