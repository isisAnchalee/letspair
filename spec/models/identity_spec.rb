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

class Auth
  attr_accessor :uid, :provider
end

RSpec.describe Identity, type: :model do
  context "validations" do
    it { should validate_presence_of :uid }
    it { should validate_presence_of :provider }
    it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  context "associations" do
    it { should belong_to :user }
  end

  context "devise" do
    it "#find_for_oauth finds an identity" do
      auth = Auth.new
      auth.uid = 5
      auth.provider = "me"
      user = FactoryGirl.create(:user)
      identity = FactoryGirl.create(:identity, user_id: user.id, uid: auth.uid, provider: auth.provider)

      expect(Identity.find_for_oauth(auth)).to eq(identity)
    end

    it "#find_for_oauth creates an identity" do
      auth = Auth.new
      auth.uid = 5
      auth.provider = "me"

      expect(Identity.all.count).to eq(0)
      Identity.find_for_oauth(auth)
      expect(Identity.all.count).to eq(1)
    end
  end

end
