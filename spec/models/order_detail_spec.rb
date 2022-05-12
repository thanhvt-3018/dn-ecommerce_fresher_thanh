require "rails_helper"

RSpec.describe OrderDetail, type: :model do
  describe "associations" do
    it {is_expected.to belong_to :order}
    it {is_expected.to belong_to :product}
  end

  describe "validates" do
    it {is_expected.to validate_presence_of :quantity}
    it {is_expected.to validate_presence_of :price}
    it {is_expected.to validate_numericality_of :quantity}
    it {is_expected.to validate_numericality_of :price}
  end

  describe "check after create" do
    let!(:user) {FactoryBot.create :user}
    let!(:order) {FactoryBot.create :order, user_id: user.id}
    let!(:category) {FactoryBot.create :category}
    let!(:product) {FactoryBot.create :product, category_id: category.id}
    let!(:order_detail) {FactoryBot.create :order_detail, order_id: order.id, product_id: product.id}

    it "update stock" do
      expect(order_detail.product.stock).to eq(product.stock - order_detail.quantity)
    end
  end
end
