module Followable
  extend ActiveSupport::Concern
  included do
    has_many :reverse_follows, class_name: "follow", dependent: :destroy
    has_many :followers, through: :reverse_follows, source: :follower
  end
end
