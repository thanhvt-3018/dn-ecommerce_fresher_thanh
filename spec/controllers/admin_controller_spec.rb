require "rails_helper"
include SessionsHelper

RSpec.describe AdminController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  describe "GET index" do
    it_behaves_like "not logged for get method", "index"

    context "when not admin login" do
      before do
        log_in user
        get :index
      end

      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("global.danger.not_admin")
      end

      it "redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end
  end
end


