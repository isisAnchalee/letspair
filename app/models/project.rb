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
#

class Project < ActiveRecord::Base
  validates :title, :user_id, :description, :complexity, presence: true
  validates :title, :description, length: { minimum: 2 }
  
  belongs_to :author, foreign_key: :user_id, class_name: "User"
  has_one :review
  has_many :bids

 def price_dollars
    self.price.to_f / 100
  end

  def price_dollars=(val)
    self.price = val * 100
  end
end
