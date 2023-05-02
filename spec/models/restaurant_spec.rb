require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe "validations" do
    subject { build(:restaurant) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:photo) }
  end
end