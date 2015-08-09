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

class Follow < ActiveRecord::Base
  # validates_uniqueness_of :follower_id, scope: :followee_id

  belongs_to :followee, class_name: "User"
  belongs_to :follower, class_name: "User"
end
