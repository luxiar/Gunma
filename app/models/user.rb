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

  enum :status, %i[active on_leave retired]

  def active?
    status == 'active'
  end

  def on_leave?
    status == 'on_leave'
  end

  def retired?
    status == 'retired'
  end

  def status_text
    case status
    when 'active'
      '在籍'
    when 'on_leave'
      '休職中'
    when 'retired'
      '退職済み'
    end
  end
end
