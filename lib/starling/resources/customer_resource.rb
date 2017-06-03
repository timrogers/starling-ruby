module Starling
  module Resources
    # A resource representing the response returned from the Customer API
    class CustomerResource < BaseResource
      # @return [String] the Starling internal ID of the customer
      def customer_uid
        parsed_data['customerUid']
      end

      # @return [String] the first name of the customer
      def first_name
        parsed_data['firstName']
      end

      # @return [String] the last name of the customer
      def last_name
        parsed_data['lastName']
      end

      # @return [Date] the date of birth of the customer
      def date_of_birth
        present_date(parsed_data['dateOfBirth'])
      end

      # @return [String] the email address of the customer
      def email
        parsed_data['email']
      end

      # @return [String] the phone number of the customer
      def phone
        parsed_data['phone']
      end
    end
  end
end
