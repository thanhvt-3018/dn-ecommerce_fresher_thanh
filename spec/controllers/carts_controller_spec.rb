require "rails_helper"

RSpec.describe CartsController, type: :controller do
  let!(:category) {FactoryBot.create :category}
  let!(:product_1) {FactoryBot.create :product, category_id: category.id}
  let!(:product_2) {FactoryBot.create :product, category_id: category.id}

  describe "GET show" do
    before do
      get :show
    end

    it "render show" do
      expect(response).to render_template :show
    end
  end

  describe "POST create" do
    before do
      session[:cart] = {product_1.id.to_s => 1}
      post :create, params: {
        product_id: product_2.id, product_id: product_1.id
      }
    end

    it "show flash success" do
      expect(flash[:success]).to eq I18n.t("global.success.add_cart")
    end

    it "redirect to referer or root path" do
      expect(response).to redirect_to request.referer || root_path
    end
  end

  describe "PATCH update" do
    context "when params is valid" do
      before do
        session[:cart] = {product_1.id.to_s => 1}
        patch :update, params: {
          session: {product_id: product_1.id, quantity: 10}
        }
      end

      it "update quantity success" do
        expect(session[:cart][product_1.id.to_s]).to eq 10
      end

      it "show flash success" do
        expect(flash[:success]).to eq I18n.t("global.success.update_cart")
      end

      it "redirect to referer or root path" do
        expect(response).to redirect_to request.referer || root_path
      end
    end

    context "when params is not valid" do
      before do
        session[:cart] = {product_1.id.to_s => 1}
        patch :update, params: {
          session: {product_id: product_1.id, quantity: -1}
        }
      end

      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("global.danger.update_cart")
      end

      it "redirect to referer or root path" do
        expect(response).to redirect_to request.referer || root_path
      end
    end
  end

  describe "DELETE destroy" do
    before do
      session[:cart] = {product_1.id.to_s => 1}
      delete :destroy, params: {
        session: {product_id: product_1.id}
      }
    end

    it "show flash success" do
      expect(flash[:success]).to eq I18n.t("global.success.remove_product_from_cart")
    end

    it "redirect to referer or root path" do
      expect(response).to redirect_to request.referer || root_path
    end
  end
end
