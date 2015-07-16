# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  admin                  :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessor :login

  has_many :projects, dependent: :destroy
  has_many :bids, foreign_key: :bidder_id

  has_many :out_follows, foreign_key: :follower_id, class_name: 'Follow'
  has_many :in_follows, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :in_follows, source: :follower
  has_many :followed_users, through: :out_follows, source: :followee
  has_many :followed_projects, through: :followed_users, source: :projects

  has_many :in_reviews, foreign_key: :reviewee_id, class_name: 'Review'
  has_many :out_reviews, foreign_key: :reviewer_id, class_name: 'Review'
  has_many :reviewers, through: :in_reviews, source: :reviewer
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }
  validates :email,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }


  # Devise
  def login=(login)
    @login = login
  end

  # Devise
  def login
    @login || self.username || self.email
  end

  # Devise
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).first
    end
  end
end
