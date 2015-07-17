# == Schema Information
#
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
#  time_line   :integer          not null
#

require 'rails_helper'

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

RSpec.describe Project, type: :model do
  
  context "validation" do
    before { FactoryGirl.create(:project) }
    it { should validate_presence_of :title }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :description }
    it { should validate_presence_of :complexity }
    it { should validate_presence_of :price }
    it { should validate_length_of(:title).is_at_least(2) }
    it { should validate_length_of(:description).is_at_least(2) }
  end
  
  context "associations" do
    before { FactoryGirl.create(:project) }
    it { should belong_to :author }
    it { should have_one(:review).dependent(:destroy) }
    it { should have_many(:bids).dependent(:destroy) }
  end

  context "methods" do

    it "#price_in_dollars" do
      project = FactoryGirl.create(:project)
      project.price_in_dollars = 30
      expect(project.price_in_dollars).to eq(30)
    end
  end
end
