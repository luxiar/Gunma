require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'last_nameのバリデーション' do
    context '適切な値のとき' do
      it '有効' do
        user = FactoryBot.build :user, last_name: 'last_name'
        expect(user).to be_valid
      end
    end

    context 'last_nameがnilのとき' do
      it '無効' do
        user = FactoryBot.build :user, last_name: nil
        expect(user).not_to be_valid
      end

      it 'エラーメッセージが"を入力してください"になる' do
        user = FactoryBot.build :user, last_name: nil
        user.valid?
        expect(user.errors[:last_name]).to include('を入力してください')
      end
    end

    context 'last_nameが空文字のとき' do
      it '無効' do
        user = FactoryBot.build :user, last_name: ''
        expect(user).not_to be_valid
      end

      it 'エラーメッセージが"を入力してください"になる' do
        user = FactoryBot.build :user, last_name: ''
        user.valid?
        expect(user.errors[:last_name]).to include('を入力してください')
      end
    end
  end

  describe 'first_nameのバリデーション' do
    context '適切な値のとき' do
      it '有効' do
        user = FactoryBot.build :user, first_name: 'first_name'
        expect(user).to be_valid
      end
    end

    context 'first_nameがnilのとき' do
      it '無効' do
        user = FactoryBot.build :user, first_name: nil
        expect(user).not_to be_valid
      end

      it 'エラーメッセージが"を入力してください"になる' do
        user = FactoryBot.build :user, first_name: nil
        user.valid?
        expect(user.errors[:first_name]).to include('を入力してください')
      end
    end

    context 'first_nameが空文字のとき' do
      it '無効' do
        user = FactoryBot.build :user, first_name: ''
        expect(user).not_to be_valid
      end

      it 'エラーメッセージが"を入力してください"になる' do
        user = FactoryBot.build :user, first_name: ''
        user.valid?
        expect(user.errors[:first_name]).to include('を入力してください')
      end
    end
  end

  describe '#retired?' do
    it '在職のユーザーだったらfalse' do
      user = FactoryBot.build :user, active: true
      expect(user.retired?).to be false
    end

    it '退職済みのユーザーだったらtrue' do
      user = FactoryBot.build :user, active: false
      expect(user.retired?).to be true
    end
  end

  describe '#status_text' do
    it '在職のユーザーだったら"在職"' do
      user = FactoryBot.build :user, active: true
      expect(user.status_text).to eq '在職'
    end

    it '退職済みのユーザーだったら"退職済み"' do
      user = FactoryBot.build :user, active: false
      expect(user.status_text).to eq '退職済み'
    end
  end

  describe '#full_name' do
    it 'last_nameとfirst_nameをスペース区切りで返す' do
      user = FactoryBot.build :user, last_name: 'full', first_name: 'name'
      expect(user.full_name).to eq 'full name'
    end
  end

  describe '#can_thumbs_up?(daily_report)' do
    it 'いいねしていない場合はtrue' do
      user = FactoryBot.build :user
      daily_report = FactoryBot.build :daily_report
      expect(user.can_thumbs_up?(daily_report)).to be true
    end

    it 'いいねしている場合はfalse' do
      user = FactoryBot.build :user
      daily_report = FactoryBot.build :daily_report
      user.like_daily_reports << daily_report
      expect(user.can_thumbs_up?(daily_report)).to be false
    end
  end
end
