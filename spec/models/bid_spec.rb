# == Schema Information
#
# Table name: bids
#
#  id         :integer          not null, primary key
#  project_id :integer          not null
#  price      :integer          not null
#  bidder_id  :integer          not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Bid, type: :model do
  context "validations" do
    
    it "properly validates a correct bid" do
      bid = Bid.new(project_id: 1, price: 1, bidder_id: 1, content: "Bla")
      expect(bid).to be_valid
    end
    
    it "properly validates an incorrect bid" do
      bid = Bid.new(project_id: 1, price: 1, bidder_id: 1, content: "")
      expect(bid).to_not be_valid
    end
  end
  
  context "associations" do
    
    it "has a project" do
      project = FactoryGirl.create(:project)
      bid = FactoryGirl.create(:bid, project_id: project.id)
      expect(bid.project).to eq(project)
    end
    
    it "has a bidder" do
      bidder = FactoryGirl.create(:user)
      bid = FactoryGirl.create(:bid, bidder_id: bidder.id)
      expect(bid.bidder).to eq(bidder)
    end
  end
end
