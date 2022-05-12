require "rails_helper"

RSpec.describe Category, type: :model do
  describe "associations" do
    it {is_expected.to have_many(:products).dependent(:destroy)}
    it {is_expected.to have_many(:children).class_name(Category.name).with_foreign_key(:parent_id).dependent(:destroy)}
    it {is_expected.to belong_to(:parent).class_name(Category.name).optional}
  end

  describe "validates" do
    it {is_expected.to validate_presence_of :name}
  end
end

