require 'spec_helper'

RSpec.describe Starling::Resources::MerchantLocationResource do
  subject(:error) { described_class.new(response: response) }
  let(:fixture) { load_fixture('merchant_location.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:merchant_uid) { is_expected.to eq('4cac93d3-f92a-440d-b4f9-fd5bac8368ba') }
  its(:merchant_location_uid) do
    is_expected.to eq('10f83832-170f-452a-8b2d-d864de381b37')
  end
  its(:merchant_name) { is_expected.to eq('Aldi') }
  its(:location_name) { is_expected.to eq('ALDI') }
  its(:mastercard_merchant_category_code) { is_expected.to eq(5411) }
end
