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

require 'rails_helper'

RSpec.describe Review, type: :model do
  
  context "validation" do
    
    it "properly validates a correct review" do
      review = Review.new(reviewer_id: 1, reviewed_id: 2, title: "Hello", body: "World", rating: 10, project_id: 1)
      expect(review).to be_valid
    end
    
    it "properly validates an incorrect review" do
      review = Review.new(reviewer_id: 1, reviewed_id: 2, title: "Hello", body: "", rating: 10, project_id: 1)
      expect(review).to_not be_valid
    end
  end
  
  context "associations" do
    
    it "has a reviewer" do
      reviewer = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review, reviewer_id: reviewer.id)
      expect(review.reviewer).to eq(reviewer)
    end
    
    it "has a reviewee" do
      reviewed = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review, reviewed_id: reviewed.id)
      expect(review.reviewed).to eq(reviewed)
    end
    
    it "has a project" do
      project = FactoryGirl.create(:project)
      review = FactoryGirl.create(:review, project_id: project.id)
      expect(review.project).to eq(project)
    end
  end
end
