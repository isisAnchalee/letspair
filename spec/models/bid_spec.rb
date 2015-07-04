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
    before { FactoryGirl.create(:bid) }
    it { should validate_presence_of :project_id }
    it { should validate_presence_of :price }
    it { should validate_presence_of :bidder_id }
    it { should validate_presence_of :content }
  end
  
  context "associations" do
    before { FactoryGirl.create(:bid) }
    it { should belong_to :project }
    it { should belong_to :bidder }
  end
end
