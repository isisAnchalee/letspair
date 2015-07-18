# == Schema Information
#
# Table name: user_profiles
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  short_tag_line :string
#  description    :text
#  work_history   :text
#  created_at     :datetime
#  updated_at     :datetime
#

class UserProfile < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id
end
