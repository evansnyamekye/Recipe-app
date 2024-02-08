require 'rails_helper'

RSpec.describe Inventory, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:inventory_foods)}
  end
end