require "rails_helper"

RSpec.describe Order, type: :model do
  describe "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to have_many(:order_details).dependent(:destroy)}
  end

  describe "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :phone}
    it {is_expected.to validate_presence_of :address}
  end

  describe "define enum for status" do
    it {is_expected.to define_enum_for :status}
  end

  describe "scope" do
    let!(:user) {FactoryBot.create :user}
    let!(:order_1) {FactoryBot.create :order, user_id: user.id}
    let!(:order_2) {FactoryBot.create :order, user_id: user.id}
    let!(:order_3) {FactoryBot.create :order, user_id: user.id}

    it "check scope order newest" do
      expect(Order.newest).to eq([order_3, order_2, order_1])
    end
  end
end
