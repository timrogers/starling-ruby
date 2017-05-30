require 'spec_helper'

RSpec.describe Starling::Middlewares::RaiseStarlingErrors do
  FakeEnv = Value.new(:status, :response_headers, :body)

  let(:middleware) { described_class.new }
  subject(:on_complete) { -> { middleware.on_complete(env) } }

  let(:env) do
    FakeEnv.with(response_headers: response_headers, status: status, body: '')
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  context 'for a successful JSON response' do
    let(:status) { 200 }

    it { is_expected.to_not raise_error }
  end

  context 'for a non-JSON response' do
    let(:response_headers) { { 'Content-Type' => 'text/html' } }

    context 'which was apparently successful' do
      let(:status) { 200 }

      it { is_expected.to raise_error(Starling::Errors::ApiError) }
    end

    context 'which responded with an error code' do
      let(:status) { 403 }

      it { is_expected.to raise_error(Starling::Errors::ApiError) }
    end
  end
end
