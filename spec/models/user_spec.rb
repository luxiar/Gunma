require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :user }
  let(:daily_report) { build :daily_report }

  describe '#retired?のテスト' do
    it '在職のユーザーだったらfalse' do
      expect(user.retired?).to be false
    end

    it '退職済みのユーザーだったらtrue' do
      user.active = false
      expect(user.retired?).to be true
    end
  end

  describe '#status_textのテスト' do
    it '在職のユーザーだったら"在職"' do
      expect(user.status_text).to eq '在職'
    end

    it '退職済みのユーザーだったら"退職済み"' do
      user.active = false
      expect(user.status_text).to eq '退職済み'
    end
  end

  describe '#full_nameのテスト' do
    it 'last_nameとfirst_nameをスペース区切りで返す' do
      expect(user.full_name).to eq '塚越 俊介'
    end
  end

  describe '#can_thumbs_up?(daily_report)のテスト' do
    it 'いいねしていない場合はtrue' do
      expect(user.can_thumbs_up?(daily_report)).to be true
    end

    it 'いいねしている場合はfalse' do
      user.like_daily_reports << daily_report
      expect(user.can_thumbs_up?(daily_report)).to be false
    end
  end
end
