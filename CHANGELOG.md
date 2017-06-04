## v0.2.0 - 4 Jun 2017

* Add support for the Transaction Faster Payments In, Transaction Faster Payments Out,
Transaction Direct Debit, Payment and Transaction Mastercard APIs
* Improve error handling behaviour to raise errors at the right time with clear,
accessible information about what went wrong
* Use Ruby 2.0+ keyword arguments rather than passing around `Hash`es
* Add full [YARD](http://yardoc.org/) documentation
* Consistently return `Float`s for all API attributes which can be integers or floats
* Refactor `Request` to remove private methods
* Refactor `Resources::BaseResource`
* Check for common code smells with [Reek](https://github.com/troessner/reek) as part of
the CI process

## v0.1.0 - 30 May 2017

* Initial release