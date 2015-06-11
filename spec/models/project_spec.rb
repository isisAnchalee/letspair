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
    
    it "properly validates a correct project" do
      project = Project.new(title: "Something", description: "Meh", user_id: 1, complexity: 10, price: 10)
      expect(project).to be_valid
    end
    
    it "properly validates an incorrect project" do
      project = Project.new(title: "Something", description: "", user_id: 1, complexity: 10, price: 10)
      expect(project).to_not be_valid
    end
  end
  
  context "associations" do
    
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
  end
end