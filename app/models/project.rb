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

  attr_accessor :price

  validates :title, :user_id, :description, :complexity, :price, presence: true
  validates :title, :description, length: { minimum: 2 }
  
  belongs_to :author, foreign_key: :user_id, class_name: "User"
  has_one :review, dependent: :destroy
  has_many :bids, dependent: :destroy


  def price_in_dollars
    self.price.to_f / 100
  end

  def price_in_dollars=(val)
    self.price = val * 100
  end
end
