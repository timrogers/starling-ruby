require 'spec_helper'

RSpec.describe Starling::Resources::BaseResource do
  context 'providing neither a resource nor parsed_data' do
    it 'raises an error' do
      expect { described_class.new }.to raise_error(/Either response or parsed_data/)
    end
  end

  class TestResource < Starling::Resources::BaseResource
    def id
      parsed_data['id']
    end
  end

  context 'providing a response, on which #body will be called' do
    let(:response) { double(body: '{ "id": "foo" }') }
    subject(:resource) { TestResource.new(response: response) }

    its(:id) { is_expected.to eq('foo') }
  end

  context 'providing pre-parsed data' do
    subject(:resource) { TestResource.new(parsed_data: { 'id' => 'foo' }) }

    its(:id) { is_expected.to eq('foo') }
  end
end
