Feature: Stamp Duty Information Table
In order to understand how my stamp duty is calculated
As a home buyer
I want to see what percentages apply to the purchase price

Scenario Outline: First time buyer
  Given I visit the Stamp Duty page
  And I am <buyer>
  When I enter a house price of <price>
  And I click next
  Then I should NOT see the first time eligibility message

  Examples:
    | buyer                                      | price  |
    | a first time buyer                         | 490000 |
    | a next home buyer                          | 490000 |
    | an additional or buy-to-let property buyer | 490000 |
    | a next home buyer                          | 510000 |
    | an additional or buy-to-let property buyer | 510000 |

Scenario: First time buyer
  Given I visit the Stamp Duty page
  And I am a first time buyer
  When I enter a house price of 510000
  And I click next
  Then I should see the first time eligibility message
