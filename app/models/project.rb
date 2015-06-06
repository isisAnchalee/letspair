class Project < ActiveRecord::Base
  validates :title, :user_id, :description, :complexity, presence: true
  
  belongs_to(
    :author,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  acts_as_taggable

 def price_dollars
    self.price.to_f / 100
  end

  def price_dollars=(val)
    self.price = val * 100
  end
  
end
