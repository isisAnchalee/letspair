# == Schema Information
#
# Table name: company_profiles
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             not null
#  location    :string
#  user_id     :integer          not null
#

class CompanyProfile < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :description, :user_id
end
