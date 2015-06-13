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
    before { FactoryGirl.create(:review) }
    it { should validate_presence_of :reviewer_id }
    it { should validate_presence_of :reviewed_id }
    it { should validate_presence_of :project_id }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_length_of(:title).is_at_least(2) }
    it { should validate_length_of(:body).is_at_least(2) }
    it { should validate_numericality_of(:rating)
                    .is_greater_than_or_equal_to(0)
                    .is_less_than_or_equal_to(100)
    }    
    it "properly validates a correct review" do
      review = Review.new(reviewer_id: 1, reviewed_id: 2, title: "Hello", body: "World", rating: 10, project_id: 1)
      expect(review).to be_valid
    end
    
    it "properly validates an incorrect review" do
      review = Review.new(reviewer_id: 1, reviewed_id: 2, title: "Hello", body: "World", rating: 101, project_id: 1)
      expect(review).to_not be_valid
    end
  end
  
  context "associations" do
    before { FactoryGirl.create(:review) }
    it { should belong_to :reviewer }
    it { should belong_to :reviewed }
    it { should belong_to :project }
  end
end
