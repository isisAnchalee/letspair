# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
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
#  first_name             :string           not null
#  last_name              :string           not null
#  is_company             :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessor :login

  has_many :projects, dependent: :destroy
  has_many :bids, foreign_key: :bidder_id, dependent: :destroy

  has_many :out_follows, foreign_key: :follower_id, class_name: 'Follow'
  has_many :in_follows, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :in_follows, source: :follower
  has_many :followed_users, through: :out_follows, source: :followee
  has_many :followed_projects, through: :followed_users, source: :projects

  has_many :in_reviews, foreign_key: :reviewee_id, class_name: 'Review'
  has_many :out_reviews, foreign_key: :reviewer_id, class_name: 'Review'
  has_many :reviewers, through: :in_reviews, source: :reviewer
  has_many :reviewed_pojects, through: :out_reviews, source: :reviewed

  has_one :user_profile, dependent: :destroy
  has_one :company_profile, dependent: :destroy

  has_many :identities, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :linkedin]

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email, case_sensitive: false

  scope :consultants, -> { where(is_company: false) }
  scope :companies, -> { where(is_company: true) }

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
            first_name: auth.info.first_name,
            last_name: auth.info.last_name,
            email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            password: Devise.friendly_token[0,20]
        )
        # user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def profile
    company_profile || user_profile
  end

end
