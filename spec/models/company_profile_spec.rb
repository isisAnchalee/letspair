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

require 'rails_helper'

RSpec.describe CompanyProfile, type: :model do

  context "validations" do
    before { FactoryGirl.create(:company_profile) }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
  end

  context "associations" do
    before { FactoryGirl.create(:company_profile) }
    it { should belong_to :user }
  end
end

