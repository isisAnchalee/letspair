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

  def first_name
    user.first_name
  end

  def last_name
    user.last_name
  end

  def full_name
    "#{first_name last_name}"
  end

  def email
    user.email
  end
end
