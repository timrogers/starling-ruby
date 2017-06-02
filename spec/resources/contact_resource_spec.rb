require 'spec_helper'

RSpec.describe Starling::Resources::ContactResource do
  subject(:transaction) { described_class.new(response: response) }
  let(:fixture) { load_fixture('contact.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:id) { is_expected.to eq('ae46414c-7cc4-44f6-8be3-d6a2296f5700') }
  its(:name) { is_expected.to eq('Alice Saunders') }
end
