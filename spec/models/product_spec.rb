require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'should have valid Factory' do
    expect(FactoryGirl.create(:product)).to be_valid
  end

  it { is_expected.to have_db_column :id }
  it { is_expected.to have_db_column :name }
  it { is_expected.to have_db_column :description }
  it { is_expected.to have_db_column :price }
  it { is_expected.to have_db_column :of_type }

  describe 'validations' do
    it { is_expected.to validate_inclusion_of(:of_type).in_array(['dish', 'cutlery']) }
  end

  describe 'scopes' do
    before do
      5.times {create(:product, of_type: 'dish')}
      create(:product, of_type: 'miscellaneous')
    end

    it "should have a dishes named scope that returns dishes" do
      expect(Product.dishes.count).to be(5)
    end

    it "should have a cutlery named scope that returns miscellaneous" do
      expect(Product.cutlery.count).to be(1)
    end
  end
end
