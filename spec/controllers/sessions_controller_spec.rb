require "rails_helper"
include SessionsHelper

RSpec.describe SessionsController, type: :controller do
  let!(:admin) {FactoryBot.create :user, role: 1}
  let!(:user) {FactoryBot.create :user}

  describe "GET new" do
    context "when admin logged" do
      before do
        log_in admin
        get :new
      end

      it "redirect to admin path" do
        expect(response).to redirect_to admin_index_path
      end
    end

    context "when user logged" do
      before do
        log_in user
        get :new
      end

      it "redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST create" do
    context "when user login success" do
      before do
        post :create, params: {
          session: {email: user.email, password: user.password}
        }
        log_in user
      end

      it "show flash success" do
        expect(flash[:success]).to eq I18n.t("global.success.log_in")
      end

      it "redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "when admin login success" do
      before do
        post :create, params: {
          session: {email: admin.email, password: admin.password}
        }
        log_in admin
      end

      it "show flash success" do
        expect(flash[:success]).to eq I18n.t("global.success.log_in")
      end

      it "redirect to admin path" do
        expect(response).to redirect_to admin_index_path
      end
    end

    context "when email not found" do
      before do
        post :create, params: {
          session: {email: "mailnotexist@example.com"}
        }
      end

      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("global.danger.email_not_found")
      end

      it "render new template" do
        expect(response).to render_template :new
      end
    end

    context "when password wrong" do
      before do
        post :create, params: {
          session: {email: user.email, password: "badpassword"}
        }
      end

      it "show flash danger" do
        expect(flash[:danger]).to eq I18n.t("global.danger.email_password_incorect")
      end

      it "render new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "DELETE destroy" do
    before do
      delete :destroy
    end

    it "redirect to root path" do
      expect(response).to redirect_to root_path
    end
  end
end
