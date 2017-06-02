require 'spec_helper'

RSpec.describe Starling::Resources::ContactAccountResource do
  subject(:transaction) { described_class.new(response: response) }
  let(:fixture) { load_fixture('contact_account.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:id) { is_expected.to eq('ae46414c-7cc4-44f6-8be3-d6a2296f5700') }
  its(:type) { is_expected.to eq(:uk_account_and_sort_code) }
  its(:name) { is_expected.to eq('Alice Saunders') }
  its(:account_number) { is_expected.to eq('55779911') }
  its(:sort_code) { is_expected.to eq('200000') }
end
