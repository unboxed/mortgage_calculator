module MortgageCalculator
  module LandAndBuildingsTransactionTaxesHelper
    def band(num1, num2)
      num1 = num1.ceil
      return maximum_band(num1 - 1) if num2.nil?
      "#{formatted_currency(num1)} - #{formatted_currency(num2)}"
    end

    def second_home_rate(rate)
      rate + LandAndBuildingsTransactionTax::SECOND_HOME_ADDITIONAL_TAX
    end

    def second_home_threshold
      formatted_currency(
        MortgageCalculator::LandAndBuildingsTransactionTax::SECOND_HOME_THRESHOLD
      )
    end

    def calculator_config_json
      calculator = MortgageCalculator::LandAndBuildingsTransactionTax
      {
        standard: calculator::STANDARD_BANDS,
        second_home_tax_rate: calculator::SECOND_HOME_ADDITIONAL_TAX,
        second_home_threshold: calculator::SECOND_HOME_THRESHOLD
      }.to_json
    end

    private

    def maximum_band(num)
      I18n.t(
        'land_and_buildings_transaction_tax.table.max',
        value: formatted_currency(num)
      )
    end

    def formatted_currency(num)
      number_to_currency(num, precision: 0)
    end
  end
end
