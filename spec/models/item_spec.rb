# frozen_string_literal: true

RSpec.describe Item, type: :model do
  describe 'has db columns' do
    it  { is_expected.to have_db_column :product_id }
    it  { is_expected.to have_db_column :order_id }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :order }
    it { is_expected.to belong_to :product }
  end
end
