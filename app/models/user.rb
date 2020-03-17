class User < ApplicationRecord
  include UserOath

  rolify
  after_create :assign_default_role

  has_many :posts
  has_many :collections

  ONLINE_PERIOD = 1.minutes
  scope :online, -> { where('updated_at > ?', ONLINE_PERIOD.ago) }
  scope :offline, -> { where('updated_at < ?', ONLINE_PERIOD.ago) }

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def online?
    updated_at > ONLINE_PERIOD.ago
  end

  def offline?
    !online?
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :trackable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :github]


  has_many :authorizations

  validates :email,    presence: true
  validates :password, presence: true

end
