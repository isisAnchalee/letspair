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

class Bid < ActiveRecord::Base
  validates :project_id, :price, :bidder_id, :content, presence: true
  validates :content, length: { minimum: 2 }
  
  belongs_to :project
  belongs_to :bidder, foreign_key: :bidder_id, class_name: "User"
  
end
