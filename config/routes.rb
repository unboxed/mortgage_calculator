MortgageCalculator::Engine.routes.draw do
  root to: "repayments#show"

  resource :repayment do
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
    resource :affordability do
      collection do
        get 'next_steps'
      end
    end
  end
end
