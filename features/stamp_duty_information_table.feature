Feature: Stamp Duty Information Table
In order to understand how my stamp duty is calculated
As a home buyer
I want to see what percentages apply to the purchase price

Scenario: First time buyer
  Given I visit the Stamp Duty page
  And I am a first time buyer
  When I reach the results page
  Then I should see the first time buyer message

Scenario: Next home buyer
  Given I visit the Stamp Duty page
  And I am a next home buyer
  When I reach the results page
  Then I should NOT see the first time buyer message
  And I should see the additional home buyer message
  And I should see the stamp duty percentages table:
    | Purchase price of property | Rate of Stamp Duty | Buy to Let/ Additional Home Rate* |
    | £0 - £125,000              | 0%                 | 3%           |
    | £125,001 - £250,000        | 2%                 | 5%           |
    | £250,001 - £925,000        | 5%                 | 8%           |
    | £925,001 - £1,500,000      | 10%                | 13%          |
    | Over £1.5 million          | 12%                | 15%          |

Scenario: Second home buyer
  Given I visit the Stamp Duty page
  And I am an additional or buy-to-let property buyer
  When I reach the results page
  Then I should NOT see the first time buyer message
  And I should see the additional home buyer message
