# == Schema Information
#
# Table name: identities
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Identity, type: :model do
  context "validations" do
    it { should validate_presence_of :uid }
    it { should validate_presence_of :provider }
    it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  context "associations" do
    it { should belong_to :user }
  end

end
