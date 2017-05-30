require 'spec_helper'

RSpec.describe Starling::Errors::ApiError do
  subject(:error) { described_class.new(env) }
  let(:env) { double(status: status, body: body) }

  context 'with a non-JSON body' do
    let(:status) { 500 }
    let(:body) { '<html><body>Internal Server Error</body></html>' }

    its(:status) { is_expected.to eq(status) }
    its(:body) { is_expected.to eq(body) }

    its(:error) { is_expected.to be_nil }
    its(:error_description) { is_expected.to be_nil }
    its(:message) { is_expected.to eq("#{status}: #{body}") }
  end

  context 'with no body' do
    let(:status) { 500 }
    let(:body) { nil }

    its(:status) { is_expected.to eq(status) }
    its(:body) { is_expected.to eq(body) }

    its(:error) { is_expected.to be_nil }
    its(:error_description) { is_expected.to be_nil }
    its(:message) { is_expected.to eq(status.to_s) }
  end

  context 'with a JSON body' do
    let(:status) { 403 }

    context 'conforming to the expected format' do
      let(:body) do
        {
          error: 'invalid_token',
          error_description: 'Could not validate provided access token'
        }.to_json
      end

      its(:status) { is_expected.to eq(status) }
      its(:body) { is_expected.to eq(body) }

      its(:error) { is_expected.to eq('invalid_token') }

      its(:error_description) do
        is_expected.to eq('Could not validate provided access token')
      end

      its(:message) do
        is_expected.to eq('403: Could not validate provided access token ' \
                          '(invalid_token)')
      end
    end

    context 'not confirming to the expected format' do
      let(:body) do
        {
          foo: 'bar'
        }.to_json
      end

      its(:status) { is_expected.to eq(status) }
      its(:body) { is_expected.to eq(body) }

      its(:error) { is_expected.to be_nil }
      its(:error_description) { is_expected.to be_nil }

      its(:message) { is_expected.to eq("#{status}: #{body}") }
    end
  end
end
