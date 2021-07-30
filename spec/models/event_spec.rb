require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "#created_by" do
    context "イベント作成したユーザが渡された場合" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:event) { FactoryBot.create(:event, owner_id: user.id) }
      it "trueを返すこと" do
        # user = double(id: event.owner_id)
        # allow(event).to receive(:created_by?).and_return(true)
        # expect(event).to receive(:created_by?)
        expect(event.created_by?(user)).to eq true
      end
    end
    context "イベント作成いたユーザ以外の場合" do
      it "falseを返すこと" do
        event = FactoryBot.create(:event)
        another_user = FactoryBot.create(:user)
        expect(event.created_by?(another_user)).to eq false
      end
    end
    context "引数がnilの場合" do
      it "falseを返す" do
        event = FactoryBot.create(:event)
        expect(event.created_by?(nil)).to eq false
      end
    end
  end
  describe "validation" do
    context "開始時間が終了時間よりも前の場合" do
      it "エラーメッセージが設定されないこと" do
        start_at = rand(1..30).days.from_now
        end_at = start_at + rand(1..30).hours
        event = FactoryBot.build(:event, start_at: start_at, end_at: end_at)
        event.valid?
        binding.pry
        expect(event.errors[:start_at]).to be_empty
      end
    end
    context "開始時間が終了時間よりも後の場合" do
      it "エラーメッセージが設定されること" do
        start_at = rand(1..30).days.from_now
        end_at = start_at - rand(1..30).hours
        event = FactoryBot.build(:event, start_at: start_at, end_at: end_at)
        event.valid?
        expect(event.errors[:start_at]).not_to be_empty
      end
    end
  end
end
