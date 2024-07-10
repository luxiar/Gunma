require 'rails_helper'

RSpec.describe DailyReport, type: :model do
  describe 'titleのバリデーション' do
    context '適切な値のとき' do
      it '有効' do
        daily_report = FactoryBot.build :daily_report, title: 'title'
        expect(daily_report).to be_valid
      end
    end

    context 'titleがnilのとき' do
      it '無効' do
        daily_report = FactoryBot.build :daily_report, title: nil
        expect(daily_report).not_to be_valid
      end

      it 'エラーメッセージが"を入力してください"になる' do
        daily_report = FactoryBot.build :daily_report, title: nil
        daily_report.valid?
        expect(daily_report.errors[:title]).to include('を入力してください')
      end
    end
  end

  describe '#mood_ja' do
    it 'moodがnormalなら"まあまあ"を返す' do
      daily_report = FactoryBot.build :daily_report, mood: :normal
      expect(daily_report.mood_ja).to eq 'まあまあ'
    end

    it 'moodがfunなら"楽しかった"を返す' do
      daily_report = FactoryBot.build :daily_report, mood: :fun
      expect(daily_report.mood_ja).to eq '楽しかった'
    end

    it 'moodがproductiveなら"捗った"を返す' do
      daily_report = FactoryBot.build :daily_report, mood: :productive
      expect(daily_report.mood_ja).to eq '捗った'
    end

    it 'moodがsleepyなら"眠かった"を返す' do
      daily_report = FactoryBot.build :daily_report, mood: :sleepy
      expect(daily_report.mood_ja).to eq '眠かった'
    end

    it 'moodがunwellなら"体調不良"を返す' do
      daily_report = FactoryBot.build :daily_report, mood: :unwell
      expect(daily_report.mood_ja).to eq '体調不良'
    end
  end

  describe '#learned_tags_str' do
    it 'learned_tagを持たないとき空文字を返す' do
      daily_report = FactoryBot.build :daily_report
      expect(daily_report.learned_tags_str).to eq ''
    end

    it 'learned_tagを持つとき","で区切って返す' do
      daily_report = FactoryBot.build :daily_report, learned_tags: [
        FactoryBot.build(:learned_tag, name: 'foo'),
        FactoryBot.build(:learned_tag, name: 'bar')
      ]
      expect(daily_report.learned_tags_str).to eq 'foo,bar'
    end
  end
end
