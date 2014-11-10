module MortgageCalculator
  class Person
    include ActiveModel::Validations
    include CurrencyInput::Macro
    include ActionView::Helpers::NumberHelper
    extend ActiveModel::Naming

    def self.i18n_scope
      "affordability.activemodel"
    end

    attr_accessor :annual_income, :extra_income, :monthly_net_income, :allow_blanks

    validates :annual_income, numericality: true, unless: :allow_blanks?
    validates :extra_income, numericality: true, unless: :allow_blanks?
    validates :monthly_net_income, numericality: true, unless: :allow_blanks?

    validate :validate_proportional_incomes

    validates :annual_income, numericality: { greater_than: 0, message: Proc.new { I18n.t("affordability.activemodel.errors.messages.blank", attribute: self.human_attribute_name(:annual_income).downcase) } }, unless: :allow_blanks?

    validates :monthly_net_income, numericality: { greater_than: 0, message: Proc.new { I18n.t("affordability.activemodel.errors.messages.blank", attribute: self.human_attribute_name(:monthly_net_income).downcase) } }, unless: :allow_blanks?

    currency_inputs :annual_income, :extra_income, :monthly_net_income

    def initialize(options = {}, param_allow_blanks = false)
      self.annual_income = options[:annual_income].presence
      self.extra_income = options[:extra_income].presence || 0
      self.monthly_net_income = options[:monthly_net_income].presence
      self.allow_blanks = param_allow_blanks
    end

    def persisted?
      false
    end

    def total_income
      safe_annual_income + safe_extra_income
    end

    def annual_income_formatted
      number_to_currency annual_income, unit: ""
    end

    def extra_income_formatted
      number_to_currency extra_income, unit: ""
    end

    def monthly_net_income_formatted
      number_to_currency monthly_net_income, unit: ""
    end

    def allow_blanks?
      return self.allow_blanks
    end

    private

    def validate_proportional_incomes
      return unless valid_number?(annual_income)

      if total_income < (monthly_net_income || 0) * 12
        errors[:base] << I18n.t("affordability.activemodel.errors.#{self.class.model_name.i18n_key}.base.proportional_incomes")
      end
    end

  protected

    def safe_annual_income
      BigDecimal.new(annual_income)
    rescue
      0
    end

    def safe_extra_income
      BigDecimal.new(extra_income)
    rescue
      0
    end

    def valid_number?(number)
      n = Float(number)

      true
    rescue
      false
    end

  end
end
