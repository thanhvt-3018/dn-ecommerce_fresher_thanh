require "rails_helper"

RSpec.describe HomeController, type: :controller do
  let!(:category_1) {FactoryBot.create :category}
  let!(:category_2) {FactoryBot.create :category}
  let!(:product_1) {FactoryBot.create :product, category_id: category_1.id}
  let!(:product_2) {FactoryBot.create :product, category_id: category_1.id}
  let!(:product_3) {FactoryBot.create :product, category_id: category_2.id}
  let!(:product_4) {FactoryBot.create :product, category_id: category_2.id}

  describe "GET index" do
    before do
      get :index
    end

    it "show home page" do
      expect(assigns(:products)).to eq([product_4, product_3, product_2, product_1])
    end
  end
end
