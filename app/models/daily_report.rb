class DailyReport < ApplicationRecord
  belongs_to :user
  has_many :daily_reports_learned_tags, dependent: :destroy
  has_many :learned_tags, through: :daily_reports_learned_tags
  has_many :thumbs_ups, dependent: :destroy
  has_many :liked_users, through: :thumbs_ups, source: :user
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user

  has_rich_text :content
  enum :mood, %i[normal fun productive sleepy unwell]

  validates :title, presence: true

  scope :filter_by_learned_tag, ->(learned_tag_id) { joins(:learned_tags).where(learned_tags: { id: learned_tag_id }) }

  def mood_ja
    {
      normal: 'まあまあ',
      fun: '楽しかった',
      productive: '捗った',
      sleepy: '眠かった',
      unwell: '体調不良'
    }[mood.to_sym]
  end

  def learned_tags_str
    learned_tags.map(&:name).join(',')
  end

  def liked_users_str
    return liked_users.map(&:last_name).join(', ') if liked_users.size <= 5

    "#{liked_users.limit(5).map(&:last_name).join(', ')}..."
  end
end
