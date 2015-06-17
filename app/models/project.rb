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
#  time_line   :integer          not null
#

class Project < ActiveRecord::Base

  ONE_MONTH                  = 0
  THREE_MONTH                = 1
  FOUR_TO_TWELVE_MONTH       = 2
  ONE_YEAR                   = 3
  PART_TIME                  = 4
  FULL_TIME                  = 5
  NEGOTIABLE                 = 6

  TIME_LINES = {
    ONE_MONTH                => "1 month",
    THREE_MONTH              => "3 month",
    FOUR_TO_TWELVE_MONTH     => "4-12 month",
    ONE_YEAR                 => "1 year",
    PART_TIME                => "part time",
    FULL_TIME                => "full time",
    NEGOTIABLE               => "negotiable"
  }

  attr_accessor :price

  validates :title, :user_id, :description, :complexity, :price, presence: true
  attr_accessor :price

  validates :title, :user_id, :description, :complexity, presence: true
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
