require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :user }
  let(:daily_report) { build :daily_report }

  describe 'last_nameのバリデーション' do
    it '値が存在すれば有効' do
      expect(user).to be_valid
    end

    it 'nilの場合無効' do
      user.last_name = nil
      user.valid?
      expect(user.errors[:last_name]).to include('を入力してください')
    end

    it '空文字の場合無効' do
      user.last_name = ''
      user.valid?
      expect(user.errors[:last_name]).to include('を入力してください')
    end
  end

  describe 'first_nameのバリデーション' do
    it '値が存在すれば有効' do
      expect(user).to be_valid
    end

    it 'nilの場合無効' do
      user.first_name = nil
      user.valid?
      expect(user.errors[:first_name]).to include('を入力してください')
    end

    it '空文字の場合無効' do
      user.first_name = ''
      user.valid?
      expect(user.errors[:first_name]).to include('を入力してください')
    end
  end

  describe '#retired?' do
    it '在職のユーザーだったらfalse' do
      expect(user.retired?).to be false
    end

    it '退職済みのユーザーだったらtrue' do
      user.active = false
      expect(user.retired?).to be true
    end
  end

  describe '#status_text' do
    it '在職のユーザーだったら"在職"' do
      expect(user.status_text).to eq '在職'
    end

    it '退職済みのユーザーだったら"退職済み"' do
      user.active = false
      expect(user.status_text).to eq '退職済み'
    end
  end

  describe '#full_name' do
    it 'last_nameとfirst_nameをスペース区切りで返す' do
      expect(user.full_name).to eq '苗字 名前'
    end
  end

  describe '#can_thumbs_up?(daily_report)' do
    it 'いいねしていない場合はtrue' do
      expect(user.can_thumbs_up?(daily_report)).to be true
    end

    it 'いいねしている場合はfalse' do
      user.like_daily_reports << daily_report
      expect(user.can_thumbs_up?(daily_report)).to be false
    end
  end
end
