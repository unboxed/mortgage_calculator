module MortgageCalculator
  class Affordability
    include CurrencyInput::Macro
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attr_reader :people

    validate :validate_people

    def people_attributes=(attributes)
    end

    def initialize(people, outgoings)
      @people = people
      @outgoings = outgoings
    end

    def total_income
      @total_income ||= people.sum(&:total_income)
    end

    def number_of_applicants
      people.length
    end

    def to_key
      nil
    end

    def persisted?
      false
    end

    def can_borrow_upto
      people.sum(&:can_borrow_upto)
    end

    def can_borrow_from
      people.sum(&:can_borrow_from)
    end

    def monthly_net_income
      people.sum(&:monthly_net_income)
    end

  private

    def validate_people
      people.each do |person|
        unless person.valid?
          person.errors.each do |error|
            errors.add(:base, error)
          end
        end
      end
    end
  end
end
