# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text             not null
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#  complexity  :integer
#  price       :integer
#  time_line   :integer          not null
#

require 'rails_helper'

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
    it "belongs to an author" do
      user = FactoryGirl.create(:user)
      project = FactoryGirl.create(:project, user_id: user.id)
      expect(project.author).to eq(user)
    end
    
    it "has one review" do
      project = FactoryGirl.create(:project)
      review = FactoryGirl.create(:review, project_id: project.id)
      expect(project.review).to eq(review)
    end
    
    it "deletes its review when destroyed" do
      project = FactoryGirl.create(:project)
      review = FactoryGirl.create(:review, project_id: project.id)
      expect(Review.all.count).to eq(1)
      project.destroy
      expect(Review.all.count).to eq(0)
    end
    
    it "has many bids" do
      project = FactoryGirl.create(:project)
      project.price_in_dollars = 30
      expect(project.price_in_dollars).to eq(30)
    end
    
    it "deletes its bids when destroyed" do
      project = FactoryGirl.create(:project)
      bid1 = FactoryGirl.create(:bid, project_id: project.id)
      bid2 = FactoryGirl.create(:bid, project_id: project.id)
      expect(Bid.all.count).to eq(2)
      project.destroy
      expect(Bid.all.count).to eq(0)
    end

  end

  context "methods" do
    it "#price_in_dollars sets the price" do
      project = FactoryGirl.create(:project)
      project.price_in_dollars = 30
      expect(project.price).to eq(3000)
    end

    it "#price_in_dollars gets the price" do
      project = FactoryGirl.create(:project)
      project.price = 3000
      expect(project.price_in_dollars).to eq(30)
    end
  end
end
