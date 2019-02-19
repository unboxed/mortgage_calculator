module MortgageCalculator
  class LandAndBuildingsTransactionTax < TaxCalculator
    def self.i18n_scope
      'land_and_buildings_transaction_tax.activemodel'
    end

    FIRST_TIME_BUYER_BANDS = [
      { threshold: 175_000, rate: 0 },
      { threshold: 250_000, rate: 2 },
      { threshold: 325_000, rate: 5 },
      { threshold: 750_000, rate: 10 },
      { threshold: nil, rate: 12 }
    ].freeze

    STANDARD_BANDS = [
      { threshold: 145_000, rate: 0 },
      { threshold: 250_000, rate: 2 },
      { threshold: 325_000, rate: 5 },
      { threshold: 750_000, rate: 10 },
      { threshold: nil, rate: 12 }
    ].freeze

    FIRST_TIME_BUYER_THRESHOLD = 175_000.freeze

    def first_time_ineligible?
      first_time_buy? && price > FIRST_TIME_BUYER_THRESHOLD
    end

    def first_time_buy?
      buyer_type == 'isFTB'
    end

    protected

    def bands_to_use
      first_time_rate? ? FIRST_TIME_BUYER_BANDS : STANDARD_BANDS
    end

    private

    def first_time_rate?
      first_time_buy? && price <= FIRST_TIME_BUYER_THRESHOLD
    end
  end
end
