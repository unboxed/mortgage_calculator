class LocaleConstraint
  attr_reader :locale

  def initialize(locale)
    @locale = locale.to_s
  end

  def matches?(request)
    request.params['locale'] == locale
  end
end

MortgageCalculator::Engine.routes.draw do
  root to: "repayments#show"

  resource :repayment do
    collection do
      get 'next_steps'
    end
  end

  resource :stamp_duty, path: 'stamp-duty-calculator' do
    collection do
      get 'next_steps'
    end
  end

  resource :stamp_duty, path: 'cyfrifiannell-treth-stamp' do
    collection do
      get 'next_steps'
    end
  end

  resource :stamp_duty do
    collection do
      get 'next_steps'
    end
  end

  resource :stamp_duty, path: 'treth_stamp' do
    collection do
      get 'next_steps'
    end
  end

  if MortgageCalculator.affordability_enabled
    resource :affordability, path: "mortgage-affordability-calculator", constraints: LocaleConstraint.new(:en) do
      get '/', to: "affordabilities#step_1"
      collection do
        get 'step_1', path: "step-1"
        match 'step_2', path: "step-2"
        match 'step_3', path: "step-3"
        get 'next_steps'
      end
    end

    resource :affordability, path: "cyfrifiannell-fforddiadwyedd-morgais", as: 'affordability_cy', constraints: LocaleConstraint.new(:cy) do
      get '/', to: "affordabilities#step_1"
      collection do
        get 'step_1', path: "step-1"
        match 'step_2', path: "step-2"
        match 'step_3', path: "step-3"
        get 'next_steps'
      end
    end
  end
end
