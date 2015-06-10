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
  
  belongs_to(
    :author,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )
  has_one :review

 def price_dollars
    self.price.to_f / 100
  end

  def price_dollars=(val)
    self.price = val * 100
  end
end
