Feature: Land Buildings Transaction Tax - First Time Buyer
So that I know how much land buildings transaction tax to pay
As a user buying my first home in Scotland
I want to enter my house price

Background:
  Given I visit the land and buildings transaction tax page

Scenario Outline: land buildings transaction tax for first home
  When I enter my house price with <price>
  And I am a first time buyer
  And I click next
  Then I see the title for the results page
  Then I see the land buildings transaction tax I will have to pay is "£<duty>"

Examples:
  | price       | duty      |
  |----------- -|-----------|
  |  £120,000   |  £0       |
  |  £175,000   |  £0       |
  |  £201,000   |  £520     |
  |  £250,000   |  £1,500   |
  |  £300,000   |  £4,000   |
  |  £325,000   |  £5,250   |
  |  £400,000   |  £12,750  |
  |  £743,000   |  £47,050  |
  |  £750,000   |  £47,750  |
  |  £1,200,000 |  £101,750 |
