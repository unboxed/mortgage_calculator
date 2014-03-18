module MortgageCalculator
  class RepaymentsController < ApplicationController
    def show
      calculate_repayment
      calculate_interest_only
      adjust_interest_rate
    end

    def create
      calculate_repayment
      calculate_interest_only
      adjust_interest_rate
      unless @repayment.valid?
        render :show
      end
    end

    def next_steps
    end


    private

      def repayment_params
        params[:repayment] || {price: 0, deposit: 0}
      end

      def repayment_model
        @repayment_model ||= Repayment.new(repayment_params)
      end

      def interest_only_model
        @interest_only ||= InterestOnly.new(repayment_params)
      end

      def calculate_repayment
        @repayment ||= RepaymentPresenter.new(repayment_model)
      end

      def calculate_interest_only
        interest_only_model
      end

      def adjust_interest_rate
        @changer = RepaymentPresenter.new(repayment_model.clone.change_interest_rate_by(1))
        @interest_only_changer = interest_only_model.clone.change_interest_rate_by(1)
      end
  end
end
