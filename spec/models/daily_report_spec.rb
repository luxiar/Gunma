require 'rails_helper'

RSpec.describe DailyReport, type: :model do
  let(:daily_report) { build :daily_report }
  let(:learned_tag1) { build :learned_tag }
  let(:learned_tag2) { build :learned_tag }

  describe 'titleのバリデーション' do
    it '値が存在すれば有効' do
      expect(daily_report).to be_valid
    end

    it 'nilの場合無効' do
      daily_report.title = nil
      daily_report.valid?
      expect(daily_report.errors[:title]).to include('を入力してください')
    end

    it '空文字の場合無効' do
      daily_report.title = ''
      daily_report.valid?
      expect(daily_report.errors[:title]).to include('を入力してください')
    end
  end

  describe '#mood_ja' do
    it 'moodがnormalなら"まあまあ"を返す' do
      daily_report.mood = :normal
      expect(daily_report.mood_ja).to eq 'まあまあ'
    end

    it 'moodがfunなら"楽しかった"を返す' do
      daily_report.mood = :fun
      expect(daily_report.mood_ja).to eq '楽しかった'
    end

    it 'moodがproductiveなら"捗った"を返す' do
      daily_report.mood = :productive
      expect(daily_report.mood_ja).to eq '捗った'
    end

    it 'moodがsleepyなら"眠かった"を返す' do
      daily_report.mood = :sleepy
      expect(daily_report.mood_ja).to eq '眠かった'
    end

    it 'moodがunwellなら"体調不良"を返す' do
      daily_report.mood = :unwell
      expect(daily_report.mood_ja).to eq '体調不良'
    end
  end

  describe '#learned_tags_str' do
    it 'learned_tagを持たないとき空文字を返す' do
      expect(daily_report.learned_tags_str).to eq ''
    end

    it 'learned_tagを持つとき","で区切って返す' do
      daily_report.learned_tags << learned_tag1
      daily_report.learned_tags << learned_tag2
      expect(daily_report.learned_tags_str).to eq "#{learned_tag1.name},#{learned_tag2.name}"
    end
  end
end
