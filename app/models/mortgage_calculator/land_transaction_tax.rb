module MortgageCalculator
  class LandTransactionTax < TaxCalculator
    def self.i18n_scope
      'land_transaction_tax.activemodel'
    end

    STANDARD_BANDS = [
      { threshold: 180_000, rate: 0 },
      { threshold: 250_000, rate: 3.5 },
      { threshold: 400_000, rate: 5 },
      { threshold: 750_000, rate: 7.5 },
      { threshold: 1_500_000, rate: 10 },
      { threshold: nil, rate: 12 }
    ].freeze

    protected

    def bands_to_use
      STANDARD_BANDS
    end

    def tax_for_band(band_start, band_end, rate)
      return 0 if price < band_start
      rate += SECOND_HOME_ADDITIONAL_TAX if second_home_taxable?
      upper_limit = price_in_band?(band_end) ? price : band_end
      amount_to_tax = upper_limit - band_start.floor
      amount_to_tax * rate / 100
    end

    def format_currency(value, precision = 2)
      number_to_currency(value, unit: '', precision: precision)
    end
  end
end
