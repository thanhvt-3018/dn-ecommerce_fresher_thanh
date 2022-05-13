require "rails_helper"

RSpec.describe Admin::Orders::OrdersHelper, type: :helper do
  let!(:user) {FactoryBot.create :user}
  let!(:order_pending) {FactoryBot.create :order, user_id: user.id}
  let!(:order_confirmed) {FactoryBot.create :order, user_id: user.id, status: 1}
  let!(:order_delivering) {FactoryBot.create :order, user_id: user.id, status: 2}
  let!(:order_received) {FactoryBot.create :order, user_id: user.id, status: 3}

  describe "#contain_status" do
    before do
      @array_status = []
      I18n.t("order_status").to_a.each{|status| @array_status.push(status.reverse)}
    end

    it "when status order is pending" do
      assign(:arr_status, @array_status)
      expect(helper.contain_status order_pending).to eq @array_status
    end

    it "when status order is confirmed" do
      assign(:arr_status, @array_status.drop(1))
      expect(helper.contain_status order_confirmed).to eq @array_status.drop(1)
    end

    it "when status order is delivering" do
      assign(:arr_status, @array_status.drop(2))
      expect(helper.contain_status order_delivering).to eq @array_status.drop(2)
    end

    it "when status order is received" do
      assign(:arr_status, @array_status.drop(3))
      expect(helper.contain_status order_received).to eq @array_status.drop(3)
    end
  end
end

