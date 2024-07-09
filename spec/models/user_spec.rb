require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#retired?のテスト' do
    let(:active_user) { FactoryBot.build(:user) }
    let(:retired_user) { FactoryBot.build(:user, active: false) }

    it '在職のユーザーだったらfalse' do
      expect(active_user.retired?).to be false
    end

    it '退職済みのユーザーだったらtrue' do
      expect(retired_user.retired?).to be true
    end
  end
end
