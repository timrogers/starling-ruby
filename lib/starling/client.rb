require 'uri'

module Starling
  # The client for the Starling Bank API, providing authenticated access to the various
  # endpoints offered in the API, with a uniform, idiomatic Ruby interface.
  class Client
    # URLs for the two Starling Bank API environments, production and sandbox
    ENVIRONMENT_BASE_URLS = {
      production: 'https://api.starlingbank.com',
      sandbox: 'https://api-sandbox.starlingbank.com'
    }.freeze

    # Instantiates a client for accessing the Starling Bank API
    #
    # @param access_token [String] A personal access token for the Starling Bank API
    # @param environment [Symbol] The API environment to use, either :production or
    #                             :sandbox
    # @param default_headers [Hash] A set of HTTP headers to add to each request,
    #                               alongside the library's defaults defined in
    #                               {Starling::ApiService#library_default_headers}
    # @param connection_options [Hash] A hash of options to be passed in when
    #                                  instantiating Faraday (for example for setting
    #                                  the request timeout)
    # @return [Starling::Client] the configured Starling client
    def initialize(access_token:, environment: :production, default_headers: {},
                   connection_options: {})
      @api_service = ApiService.new(fetch_base_url_for_environment(environment),
                                    access_token: access_token,
                                    default_headers: default_headers,
                                    connection_options: connection_options)
    end

    # Provides access to the Account API
    #
    # @return [Starling::Services::AccountService] a configured service for accessing the
    #                                              Account API
    def account
      Services::AccountService.new(@api_service)
    end

    # Provides access to the Account Balance API
    #
    # @return [Starling::Services::AccountBalanceService] a configured service for
    #                                                     accessing the Account Balance
    #                                                     API
    def account_balance
      Services::AccountBalanceService.new(@api_service)
    end

    # Provides access to the Transactions API
    #
    # @return [Starling::Services::TransactionsService] a configured service for
    #                                                   accessing the Transactions API
    def transactions
      Services::TransactionsService.new(@api_service)
    end

    # Provides access to the Merchants API
    #
    # @return [Starling::Services::MerchantsService] a configured service for accessing
    #                                                the Merchants API
    def merchants
      Services::MerchantsService.new(@api_service)
    end

    # Provides access to the Merchants Locations API
    #
    # @return [Starling::Services::MerchantLocationsService] a configured service for
    #                                                        accessing the Merchant
    #                                                        Locations API
    def merchant_locations
      Services::MerchantLocationsService.new(@api_service)
    end

    # Provides access to the Card API
    #
    # @return [Starling::Services::CardService] a configured service for accessing the
    #                                           Card API
    def card
      Services::CardService.new(@api_service)
    end

    # Provides access to the Who Am I (Me) API
    #
    # @return [Starling::Services::MeService] a configured service for accessing the Who
    #                                         Am I (Me) API
    def me
      Services::MeService.new(@api_service)
    end

    # Provides access to the Customer API
    #
    # @return [Starling::Services::CustomerService] a configured service for accessing
    #                                               the Customer API
    def customer
      Services::CustomerService.new(@api_service)
    end

    # Provides access to the Addresses API
    #
    # @return [Starling::Services::AddressesService] a configured service for accessing
    #                                                the Addresses API
    def addresses
      Services::AddressesService.new(@api_service)
    end

    # Provides access to the Direct Debit Mandates API
    #
    # @return [Starling::Services::DirectDebitMandatesService] a configured service for
    #                                                          accessing the Direct Debit
    #                                                          Mandates API
    def direct_debit_mandates
      Services::DirectDebitMandatesService.new(@api_service)
    end

    # Provides access to the Contacts API
    #
    # @return [Starling::Services::ContactsService] a configured service for accessing
    #                                               the Contacts API
    def contacts
      Services::ContactsService.new(@api_service)
    end

    # Provides access to the Contact Accounts API
    #
    # @return [Starling::Services::ContactAccountsService] a configured service for
    #                                                      accessing the Contact Accounts
    #                                                      API
    def contact_accounts
      Services::ContactAccountsService.new(@api_service)
    end

    private

    def fetch_base_url_for_environment(environment)
      ENVIRONMENT_BASE_URLS.fetch(environment) do
        raise ArgumentError, "#{environment} is not a valid environment, must be one " \
                             "of #{ENVIRONMENT_BASE_URLS.keys.join(', ')}"
      end
    end
  end
end
