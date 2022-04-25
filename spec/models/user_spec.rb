require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it {is_expected.to have_many(:orders).dependent(:destroy)}
  end

  describe "validates" do
    context "validate presence" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_presence_of :password}
      it {is_expected.to validate_presence_of :email}
    end

    context "validate unique email" do
      it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    end

    context "validate length of password" do
      it {is_expected.to validate_length_of(:password).is_at_least(Settings.length_8).is_at_most(Settings.length_20)}
    end
  end

  describe "define enum for role" do
    it {is_expected.to define_enum_for :role}
  end
end
