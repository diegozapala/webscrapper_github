require "rails_helper"

RSpec.describe Profile, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:username) }

    it { should validate_uniqueness_of(:name) }
  end
end
