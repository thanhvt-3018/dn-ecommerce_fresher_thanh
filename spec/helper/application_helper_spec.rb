require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    context "when have page title" do
      let!(:title) {"Test title"}

      it "get expected title" do
        expect(helper.full_title title).to eq(title << " | " << I18n.t("global.base_title"))
      end
    end

    context ("when page title is empty") do
      let!(:title) {""}

      it "get expected title" do
        expect(helper.full_title title).to eq(I18n.t("global.base_title"))
      end
    end
  end
end
