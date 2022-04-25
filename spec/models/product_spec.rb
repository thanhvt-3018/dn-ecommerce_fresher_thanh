require "rails_helper"

RSpec.describe Product, type: :model do
  let!(:category) {FactoryBot.create :category}
  let!(:product_1) {FactoryBot.create :product, category_id: category.id}
  let!(:product_2) {FactoryBot.create :product, category_id: category.id}
  let!(:product_3) {FactoryBot.create :product, category_id: category.id}

  describe "associations" do
    it {is_expected.to belong_to :category}
    it {is_expected.to have_many(:order_details).dependent(:destroy)}
    it {is_expected.to have_one_attached :image}
  end

  describe "validates" do
    context "validate presence" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_presence_of :product_sku}
      it {is_expected.to validate_presence_of :title}
      it {is_expected.to validate_presence_of :description}
      it {is_expected.to validate_presence_of :price}
    end

    context "validate price is numericality" do
      it {is_expected.to validate_numericality_of :price}
    end

    context "validate uniqueness product sku" do
      it {is_expected.to validate_uniqueness_of :product_sku}
    end
  end

  describe "scope" do
    before do
      @ids = [product_1.id, product_3.id]
    end

    it "check scope product newest" do
      expect(Product.newest).to eq([product_3, product_2, product_1])
    end

    it "check scope find by list id" do
      expect(Product.by_ids @ids).to eq([product_1, product_3])
    end
  end
end
