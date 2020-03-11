class User < ApplicationRecord
  ONLINE_PERIOD = 1.minutes
  has_many :posts
  scope :online, -> { where('updated_at > ?', ONLINE_PERIOD.ago) }
  scope :offline, -> { where('updated_at < ?', ONLINE_PERIOD.ago) }

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
         :recoverable, :rememberable, :validatable

end
