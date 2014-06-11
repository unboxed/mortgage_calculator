Then(/^My repayment completion interaction is tracked$/) do
  expect(page).to have_analytics_event(['_trackEvent', 'Mortgage Calculator', 'Completion', 'Click'])
end

Then(/^My stamp duty completion interaction is tracked$/) do
  expect(page).to have_analytics_event(['_trackEvent', 'Stamp Duty Calculator', 'Completion', 'Click'])
end

When(/^I refine my details$/) do
  @repayment.step_two_price.set "200000"
  @repayment.step_two_price.set "300000"
  @repayment.step_two_price.set "400000"
  @repayment.step_two_deposit.set "20000"

  @repayment.term_years.set "30"
  @repayment.interest_rate.set "3"
end

Then(/^My repayment refinement interaction is tracked$/) do
  expect(page).to have_analytics_event(['_trackEvent', 'Mortgage Calculator', 'Refinement', 'Price'])
end

Then(/^My stamp duty next steps interaction is tracked$/) do
  expect(page).to have_analytics_event(['_trackEvent', 'Stamp Duty Calculator', 'Next Steps', 'Click'])
end

Then(/^My repayment next steps interaction is tracked$/) do
  expect(page).to have_analytics_event(['_trackEvent', 'Mortgage Calculator', 'Next Steps', 'Click'])
end

Then(/^My affordability completion interaction is tracked$/) do
  expect(page).to have_analytics_event(['_trackEvent', 'Affordability Calculator', 'Completion', 'Click'])
end

Then(/^My affordability borrowing refinement interaction is tracked$/) do
  expect(page).to have_analytics_event(['_trackEvent', 'Affordability Calculator', 'Refinement', 'Borrowing'])
end

Then(/^My affordability interest rate refinement interaction is tracked$/) do
  expected = ['_trackEvent','Affordability Calculator','Refinement','Interest Rate']
  expect(page).to have_analytics_event(expected)
end

Then(/^My affordability lifestyle refinement interaction is tracked$/) do
  expected = ['_trackEvent','Affordability Calculator','Refinement','Lifestyle']
  expect(page).to have_analytics_event(expected)
end

Then(/^My risk level is tracked$/) do
  expected = ['_trackEvent','Affordability Calculator','Risk Level','high']
  expect(page).to have_analytics_event(expected)
end

Then(/^My negative remainging is tracked$/) do
  expected = ['_trackEvent','Affordability Calculator','Remaining','Non-positive']
  expect(page).to have_analytics_event(expected)
end

Then(/^My negative remainging is not tracked$/) do
  expected = ['_trackEvent','Affordability Calculator','Remaining','Non-positive']
  expect(page).to_not have_analytics_event(expected)
end

