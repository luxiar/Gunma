class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable, :recoverable, :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable

  has_many :daily_reports, dependent: :destroy
  has_many :thumbs_ups, dependent: :destroy
  has_many :like_daily_reports, through: :thumbs_ups, source: :daily_report
  has_many :comments, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true

  def retired?
    !active
  end

  def status_text
    active? ? '在職' : '退職済み'
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    active? ? super : :retired
  end

  def can_thumbs_up?(daily_report)
    !like_daily_reports.include?(daily_report)
  end

  def self.ransackable_attributes(_auth_object = nil)
    ['id']
  end
end
